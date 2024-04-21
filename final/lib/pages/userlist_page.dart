import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/user_tile.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  // set gid
  final String gid;

  //get service
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //group location
  final double g_latitude;
  final double g_longtitude;

  UserListPage({super.key, required this.gid, required this.g_latitude, required this.g_longtitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: page_bar("User List", context),
      body: _buildUserList(g_latitude, g_longtitude),
      backgroundColor: Color.fromRGBO(244, 230, 217, 1),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList(g_latitude, g_longtitude) {
    return StreamBuilder(
        stream: _chatService.getUserInGroupStream(gid),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          // loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          // create List of users
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(
                    userData, context, g_latitude, g_longtitude))
                .toList(),
          );
        });
  }

  // build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context,
      g_latitude, g_longtitude) {
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
            u_latitude: data["latitude"],
            u_longtitude: data["longtitude"],
            enable: userData["enable"],
            g_latitude: g_latitude,
            g_longtitude: g_longtitude,
          );
        }
      },
    );
  }
}
