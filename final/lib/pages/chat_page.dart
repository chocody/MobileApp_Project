import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/chat_bubble.dart';
import 'package:demo_chat/components/my_textfield.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/pages/createevent_page.dart';
import 'package:demo_chat/pages/userlist_page.dart';
import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String gid;

  ChatPage({
    super.key,
    required this.groupName,
    required this.gid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  // show groupID
  void showGroupID() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Group ID : \n" + widget.gid),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // wait a bit for listview to be built, then scroll to bottom
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(widget.gid, _messageController.text);

      //clear text controller
      _messageController.clear();
    }

    scrollDown();
  }

  void toCreatEventPage(BuildContext context) {
    // go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateEventPage(gid: widget.gid),
        ));
  }

  void toUserListPage(BuildContext context) {
    // go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserListPage(
            gid: widget.gid,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 230, 217, 1),
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
        title: Row(
          children: [
            text(widget.groupName, Colors.white, 24),
          ],
        ),
        actions: [
          IconButton(
              onPressed: showGroupID, icon: Icon(Icons.info_outline)),
          IconButton(
              onPressed: () => toCreatEventPage(context),
              icon: Icon(Icons.event)),
          IconButton(
              onPressed: () => toUserListPage(context), icon: Icon(Icons.list)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.gid),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          // return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender isthe current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child:
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser));
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // text field should take up most of the space
          Expanded(
              child: MytextField(
            hintText: "Type a message",
            obscureText: false,
            controller: _messageController,
            focusNode: myFocusNode,
            color: Colors.white,
          )),
          //send button
          IconButton(
                onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
