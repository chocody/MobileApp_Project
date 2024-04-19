import "package:cloud_firestore/cloud_firestore.dart";
import "package:demo_chat/components/user_tile.dart";
import "package:demo_chat/pages/chat_page.dart";
import "package:demo_chat/services/auth/auth_service.dart";
import "package:demo_chat/services/chat/chat_service.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget{
  HomePage({super.key});

  // chat & auth service & firestore
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void logout() {
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  void addgroup(){
    //get chat service
    final ChatService _chat = ChatService();
    _chat.addGroup();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      elevation: 0, 
      actions: [
        // logout button
        IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        IconButton(onPressed: addgroup, icon: Icon(Icons.add))
      ],
      ),
      body: _buildGroupList(),
    );
  }

  // build a list of users except for the current logged in user
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

          return UserTile(
            text: data["groupName"], 
            onTap: () {
              // tapped on a user -> go to chat page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      groupName: data["groupName"],
                      gid: groupData["gid"],
                    ),
                  ));
            },
          );
        }
      },
    );
  }
}