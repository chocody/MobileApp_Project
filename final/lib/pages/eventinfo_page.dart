import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventInfoPage extends StatelessWidget {
  final String eid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  EventInfoPage({
    super.key,
    required this.eid
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event List"),
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.grey,  
      ),
      body: _buildEventInfo(context),
    );
  }

  Widget _buildEventInfo(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection("events").doc(eid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error fetching data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final data = snapshot.data!.data()! as Map<String, dynamic>;

          return Text(data["eventName"]);
        }
      },
    );
  }
}