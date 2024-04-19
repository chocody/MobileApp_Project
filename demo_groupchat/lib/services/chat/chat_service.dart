

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  //get instance of auth & firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  /*

  List<Map<String,dynamic>> =
  [
  {
    'email': a@gmail.com,
    'id': ...
  },
  {
    'email': b@gmail.com,
    'id': ...
  }
  ]

  */
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go thought each individual user
        final user = doc.data();
        
        // return user
        return user;
      }).toList();
    });
  }

  //get group stream
  Stream<List<Map<String,dynamic>>> getGroupsStream(){
    return _firestore.collection("user_group").where("uid", isEqualTo: _auth.currentUser!.uid).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go thought each individual user
        final group = doc.data();
        // return user
        return group;
      }).toList();
    });
  }


  //send message
  Future<void> sendMessage(String groupID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new massage
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      groupID: groupID,
      message: message,
      timestamp: timestamp
    );    

    // add new message to the database
    await _firestore
      .collection("chat_rooms")
      .doc(groupID)
      .collection("messages")
      .add(newMessage.toMap());
  }

  //get massages
  Stream<QuerySnapshot> getMessages(String groupID) {
  
    return _firestore
      .collection("chat_rooms")
      .doc(groupID)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
  }

  //add new group
  Future<void> addGroup() async{
    final groupInfo = {
      "groupName": "a",
      "creator" : _auth.currentUser!.uid,
    };
    final addedGroup = await _firestore.collection("groups").add(groupInfo);

    final relation = {
      "gid": addedGroup.id,
      "uid" : _auth.currentUser!.uid,
    };
    await _firestore.collection("user_group").doc().set(relation);
  }

  //join group
  Future<void> joinGroup(groupID) async{
    final relation = {
      "gid": groupID,
      "uid" : _auth.currentUser!.uid,
    };
    await _firestore.collection("user_group").doc().set(relation);
  }

}