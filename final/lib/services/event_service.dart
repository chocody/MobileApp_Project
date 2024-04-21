import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventService {
  //get instance of firestore & storage & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add new event
  Future<void> addEvent(
      gid, eventName, description, date, time, Uint8List file) async {
    //upload Image
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('event_images/$imageName.jpg');
    UploadTask _uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await _uploadTask;
    String imgUrl = await snapshot.ref.getDownloadURL();

    //add event infomation
    final eventInfo = {
      "eventName": eventName,
      "description": description,
      "gid": gid,
      "date": date,
      "time": time,
      "image": imgUrl,
    };

    final addedEvent = await _firestore.collection("events").add(eventInfo);

    //add relation between all user in group and event
    QuerySnapshot userSnapshot = await _firestore
        .collection("user_group")
        .where("gid", isEqualTo: gid)
        .get();

    List<Map<String, dynamic>> userList = [];

    for (QueryDocumentSnapshot userDoc in userSnapshot.docs) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      userList.add(userData);
    }

    for (Map<String, dynamic> user in userList) {
      final relation = {
        "eid": addedEvent.id,
        "uid": user["uid"],
        "joined": false,
      };
      await _firestore
          .collection("user_event")
          .doc(addedEvent.id + user["uid"])
          .set(relation);
    }
  }

  //get event stream
  Stream<List<Map<String, dynamic>>> getEventsStream() {
    return _firestore
        .collection("user_event")
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // go thought each individual group
        final event = doc.data();
        // return group
        return event;
      }).toList();
    });
  }

  // joined
  Future<void> joinedEvent (String eid) async {
    String ref = eid + _auth.currentUser!.uid;
    await _firestore.collection("user_event").doc(ref).get().then((data) async{
      await _firestore.collection("user_event").doc(ref).update({"joined": !data["joined"]});
    });
  }

  //get user stream
  Stream<List<Map<String,dynamic>>> getUsersStream(eid){
    return _firestore.collection("user_event").where("eid", isEqualTo:eid).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go thought each individual group
        final user = doc.data();
        // return group
        return user;
      }).toList();
    });
  }

}
