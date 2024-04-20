import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/event_tile.dart';
import 'package:demo_chat/pages/eventinfo_page.dart';
import 'package:demo_chat/services/event_service.dart';
import 'package:flutter/material.dart';

class EventListPage extends StatelessWidget {
  // firestore & event service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EventService _eventService = EventService();
  
  
  EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event List"),
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.grey,  
      ),
      body: _buildEventList(context),
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
            text: data["eventName"], 
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
