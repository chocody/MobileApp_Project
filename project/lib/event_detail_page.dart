import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: page_bar("Event Detail", context),
      body: Center(
        child: SingleChildScrollView(
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
                        'assets/picture/court1.png'), // Replace with your image path
                    fit:
                        BoxFit.cover, // Adjust as needed (cover, contain, etc.)
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
                  text("Street basketball", Colors.black, 24)
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
                  text("17 FEB 2024, 13:00-15:00", Colors.black, 16)
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
                  text("แข่งแบบ 3x3", Colors.black, 16),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  text("ลงแข่งทีมละ 10 นาที", Colors.black, 16),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  text("เส้น3แต้มนับ 2 คะแนน, ข้างในนับ 1 คะแนน", Colors.black,
                      16),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 300.0, // Set the desired width
                child: ElevatedButton(
                    onPressed: () {
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
        ),
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
