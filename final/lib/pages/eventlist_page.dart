import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/event_tile.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/pages/eventinfo_page.dart';
import 'package:demo_chat/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// class EventPage extends StatefulWidget {
//   @override
//   State<EventPage> createState() => _EventPageState();
// }

// class _EventPageState extends State<EventPage> {
//   final Geolocator geolocator = Geolocator();
//   Position? currentLocation;
//   String myLocation = '';
//   late bool servicePermission = false;
//   late LocationPermission permission;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<Position> _getCurrentLocation() async {
//     servicePermission = await Geolocator.isLocationServiceEnabled();
//     if (!servicePermission) {
//       print("Service disabled");
//     }

//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: nav_bar(context),
//       body: StreamBuilder(
//           stream:
//               FirebaseFirestore.instance.collection("events").snapshots(),
//           builder: (context, snapshot) {
//             int count = 0;
//             return ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (context, index) {
//                 print(snapshot.data?.docs[index]["eventName"]);
//                 print(snapshot.data?.docs[index]["date"]);
//                 print(snapshot.data?.docs[index]["time"]);
//                 print(snapshot.data?.docs[index]["description"]);
//                 print("------------------------------------------------");
//                 String event_name =
//                     (snapshot.data?.docs[index]["eventName"]).toString();
//                 String event_time =
//                     (snapshot.data?.docs[index]["time"]).toString();
//                 String event_date =
//                     (snapshot.data?.docs[index]["date"]).toString();
//                 String event_image =
//                     (snapshot.data?.docs[index]["image"]).toString();
//                 count += 1;
//                 print(count);
//                 // return banner_event(
//                 //     false, event_name, event_time, event_date, count,event_image, context);
//               },
//             );
//           }),
//       backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
//     );
//   }
// }

class EventListPage extends StatelessWidget {
  // firestore & event service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EventService _eventService = EventService();
  
  
  EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(context),
      body: _buildEventList(context),
      backgroundColor: Color.fromRGBO(244, 230, 217, 1),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return StreamBuilder(
      stream: _eventService.getEventsStream(),
      builder: (context, snapshot){
        
        // error
        if (snapshot.hasError){
          return const Text("Error");
        }

        // loading...
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading..");
        }

        // create List of event
        return ListView(
          children: snapshot.data!.map<Widget>((eventData) => _buildEventListItem(eventData, context)).toList(),
        );

      });
  }


  // build individual list tile for event
  Widget _buildEventListItem(Map<String, dynamic> eventData, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection("events").doc(eventData["eid"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error fetching data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final data = snapshot.data!.data()! as Map<String, dynamic>;
          return EventTile(
            event_name: data["eventName"],
            event_date: data["date"],
            event_time: data["time"],
            event_img: data["image"],
            onTap: () {
              // tapped on a group -> go to eventinfo page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventInfoPage(
                      eid: eventData["eid"],
                    ),
                  )
              );
            },
          );
        }
      },
    );
  }
}
