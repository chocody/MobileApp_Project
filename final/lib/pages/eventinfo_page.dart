// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_chat/pages/eventlist_page.dart';
// import 'package:flutter/material.dart';

// class EventInfoPage extends StatelessWidget {
//   final String eid;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   EventInfoPage({
//     super.key,
//     required this.eid
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Event List"),
//         backgroundColor: Colors.transparent,
//         // foregroundColor: Colors.grey,
//       ),
//       body: _buildEventInfo(context),
//     );
//   }

//   Widget _buildEventInfo(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: _firestore.collection("events").doc(eid).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error fetching data');
//         } else if (!snapshot.hasData || snapshot.data == null) {
//           return Text('No data available');
//         } else {
//           final data = snapshot.data!.data()! as Map<String, dynamic>;

//           return Text(data["eventName"]);
//         }
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/pages/eventlist_page.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class EventInfoPage extends StatefulWidget {
  @override
  State<EventInfoPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    // int number = ModalRoute.of(context)?.settings.arguments as int;
    int number = 1;

    return Scaffold(
      appBar: page_bar("Event Detail", context),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("events").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (context, index) {
              print(number);
              try {
                String event_name =
                    (snapshot.data?.docs[number]["eventName"]).toString();
                String event_time =
                    (snapshot.data?.docs[number]["time"]).toString();
                String event_date =
                    (snapshot.data?.docs[number]["date"]).toString();
                String event_detail =
                    (snapshot.data?.docs[number]["description"]).toString();
                String event_img =
                    (snapshot.data?.docs[number]["img"]).toString();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 300.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(event_img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          text(event_name, Colors.black, 24)
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          text("by basketball court 1", Colors.black, 16)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.access_time,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          text("${event_date}, ${event_time}", Colors.black, 16)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 30,
                          ),
                          text(event_detail, Colors.black, 16),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300.0, // Set the desired width
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed(
                              //   "event",
                              //   arguments: true,
                              // );
                            },
                            child: Text("Let's join",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(164, 151, 134, 1),
                            )),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          text("Participation:", Colors.black, 16)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      person_tile("Jane Cooper"),
                      person_tile("Jane Cooper"),
                      person_tile("Jane Cooper"),
                      person_tile("Jane Cooper"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              } catch (e) {
                return EventPage();
              }
            },
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
