

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {

  //get instance of auth & firestore & storage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
        // go thought each individual group
        final group = doc.data();
        // return group
        return group;
      }).toList();
    });
  }

  //get users in group 
  Stream<List<Map<String,dynamic>>> getUserInGroupStream(String gid){
    return _firestore.collection("user_group").where("gid", isEqualTo: gid).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go thought each individual user
        final user = doc.data();
        // return user
        return user;
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
  Future<void> addGroup(String groupName, String description, Uint8List file) async{
    
    //upload Image
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('group_images/$imageName.jpg');
    UploadTask _uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await _uploadTask;
    String imgUrl = await snapshot.ref.getDownloadURL();

    //add group infomation
    final groupInfo = {
      "groupName": groupName,
      "description": description,
      "creator" : _auth.currentUser!.uid,
      "image":imgUrl,
    };

    final addedGroup = await _firestore.collection("groups").add(groupInfo);
    
    //add relation between group and current user
    final relation = {
      "gid": addedGroup.id,
      "uid" : _auth.currentUser!.uid,
    };
    await _firestore.collection("user_group").doc(addedGroup.id + _auth.currentUser!.uid).set(relation);
  }

  //join group
  Future<void> joinGroup(groupID) async{
    final uid = _auth.currentUser!.uid;

    // check group exist
    final groupExistence = await _firestore
      .collection("groups")
      .doc(groupID)
      .get().then((value) => value.exists,);
  
    if (groupExistence){

      // check relation dont exist
      final relationExistence = await _firestore
        .collection("user_group")
        .doc(groupID+uid)
        .get().then((value) => value.exists,
      );
      if (! relationExistence) {
        final relation = {
          "gid": groupID,
          "uid" : uid,
        };
        await _firestore.collection("user_group").doc(groupID+uid).set(relation); 
      }
    }
    
  }

}