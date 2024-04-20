import "package:cloud_firestore/cloud_firestore.dart";
import "package:demo_chat/components/group_tile.dart";
import "package:demo_chat/components/popup_textfield.dart";
import "package:demo_chat/pages/chat_page.dart";
import "package:demo_chat/pages/creategroup_page.dart";
import "package:demo_chat/pages/eventlist_page.dart";
import "package:demo_chat/pages/profile_page.dart";
import "package:demo_chat/services/chat/chat_service.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget{
  HomePage({super.key});

  // chat & auth service & firestore
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void toProfilePage(BuildContext context) {
    // go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        )
    );
  }

  void toCreateGroupPage(BuildContext context){
    // go to create group page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroupPage(),
        )
    );
  }
  void toEventListPage(BuildContext context){
    // go to evenlist page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventListPage(),
        )
    );
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.grey,
        elevation: 0,
        leading: IconButton(onPressed: () => toProfilePage(context), icon: Icon(Icons.person)),
        actions: [
          IconButton(onPressed: () =>toCreateGroupPage(context), icon: Icon(Icons.add)),
          IconButton(onPressed: () => joingroup(context), icon: Icon(Icons.search)),
          IconButton(onPressed: () =>toEventListPage(context), icon: Icon(Icons.event)),
        ],
      ),
      body: _buildGroupList(),
    );
  }
  
  //


  // build a list of current user's groups 
  Widget _buildGroupList() {
    return StreamBuilder(
      stream: _chatService.getGroupsStream(),
      builder: (context, snapshot){
        
        // error
        if (snapshot.hasError){
          return const Text("Error");
        }

        // loading...
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading..");
        }

        // create List of group
        return ListView(
          children: snapshot.data!.map<Widget>((groupData) => _buildGroupListItem(groupData, context)).toList(),
        );

      });
  }


  // build individual list tile for group
  Widget _buildGroupListItem(Map<String, dynamic> groupData, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection("groups").doc(groupData["gid"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error fetching data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final data = snapshot.data!.data()! as Map<String, dynamic>;

          return GroupTile(
            text: data["groupName"], 
            onTap: () {
              // tapped on a group -> go to chat page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      groupName: data["groupName"],
                      gid: groupData["gid"],
                    ),
                  )
              );
            },
          );
        }
      },
    );
  }
}