import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String groupID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.groupID,
    required this.message,
    required this.timestamp
  });
  
  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderEmail,
      "receiver" :groupID,
      "message" : message,
      "timestamp" : timestamp,
    };
  }
}