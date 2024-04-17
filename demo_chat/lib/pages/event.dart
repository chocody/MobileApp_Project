import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/widget.dart';
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
  late bool servicePermission = false;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(context),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Event Detail").snapshots(),
          builder: (context, snapshot) {
            int count = 0;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data?.docs[index]["Event name"]);
                print(snapshot.data?.docs[index]["Date"]);
                print(snapshot.data?.docs[index]["Time"]);
                print(snapshot.data?.docs[index]["Detail"]);
                print("------------------------------------------------");
                String event_name =
                    (snapshot.data?.docs[index]["Event name"]).toString();
                String event_time =
                    (snapshot.data?.docs[index]["Time"]).toString();
                String event_date =
                    (snapshot.data?.docs[index]["Date"]).toString();
                count += 1;
                print(count);
                return banner_event(
                    false, event_name, event_time, event_date, count, context);
              },
            );
          }),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
