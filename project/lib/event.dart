import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(context),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Event Detail").snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data?.docs[index]["Event name"]);
                print(snapshot.data?.docs[index]["Date"]);
                print(snapshot.data?.docs[index]["Time"]);
                String event_name = (snapshot.data?.docs[index]["Event name"]).toString();
                String event_time = (snapshot.data?.docs[index]["Time"]).toString();
                String event_date = (snapshot.data?.docs[index]["Date"]).toString();
                return banner_event(true, event_name, event_time, event_date, context);
              },
            );
          }),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
