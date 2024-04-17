import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final Geolocator geolocator = Geolocator();
  Position? currentLocation;
  String myLocation = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Your current location: ${position.latitude}, ${position.longitude}');
  }

  Widget build(BuildContext context) {
    int count = 0;
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
                print(snapshot.data?.docs[index]["Detail"]);
                String event_name =
                    (snapshot.data?.docs[index]["Event name"]).toString();
                String event_time =
                    (snapshot.data?.docs[index]["Time"]).toString();
                String event_date =
                    (snapshot.data?.docs[index]["Date"]).toString();
                count += 1;
                return banner_event(
                    false, event_name, event_time, event_date, count, context);
              },
            );
          }),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
