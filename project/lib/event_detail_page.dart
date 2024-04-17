import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class EventDetailPage extends StatefulWidget {
  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    int number = ModalRoute.of(context)?.settings.arguments as int;
    number = number - 7;

    return Scaffold(
      appBar: page_bar("Event Detail", context),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Event Detail").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (context, index) {
              // print(number);
              String event_name =
                  (snapshot.data?.docs[number]["Event name"]).toString();
              String event_time =
                  (snapshot.data?.docs[number]["Time"]).toString();
              String event_date =
                  (snapshot.data?.docs[number]["Date"]).toString();
              String event_detail =
                  (snapshot.data?.docs[number]["Detail"]).toString();
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
                          image: AssetImage(
                              'assets/picture/court1.png'),
                          fit: BoxFit
                              .cover,
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
            },
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
