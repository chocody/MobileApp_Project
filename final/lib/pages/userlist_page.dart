import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/user_tile.dart';
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {

  // set gid
  final String gid;

  //get service
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  UserListPage({
    super.key,
    required this.gid
  });

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {

    return StreamBuilder(
      stream: _chatService.getUserInGroupStream(gid),
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
          children: snapshot.data!.map<Widget>((userData) => _buildGroupListItem(userData, context)).toList(),
        );

      });
  }

  // build individual list tile for group
  Widget _buildGroupListItem(Map<String, dynamic> userData, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection("Users").doc(userData["uid"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error fetching data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No data available');
        } else {
          final data = snapshot.data!.data()! as Map<String, dynamic>;

          return UserTile(
            text: data["username"],
            imgpath: data["image"],
          );
        }
      },
    );
  }
}