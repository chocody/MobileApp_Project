import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/my_button.dart';
import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  ProfilePage({super.key,});

  //auth service & firestore
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void logout(BuildContext context) {
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: _firestore
                .collection("Users").doc(_authService.getCurrentUser()!.uid).get(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final data = snapshot.data!.data()!;
                    return Column(
                      children: [
                        // profile image
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(data["image"]),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        // username
                        Text(data["username"]),

                        const SizedBox(
                          height: 25,
                        ),

                        //logout button
                        MyButton(
                          text: "LOGOUT",
                          onTap: () => logout(context),
                        ),
                      ],
                    );
                }
                
              }
            ),
            
          ],
        ),
      ),
    );
  }
  
}