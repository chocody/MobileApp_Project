import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

class EventCreatePage extends StatefulWidget {

  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: page_bar("Create Event",context),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 10),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Event name",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Date",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield("DD/MM/YYYY"),
              SizedBox(
                width: 100,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Time",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              text(" : ",Colors.black,24),
              textfield(""),
              SizedBox(
                width: 120,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Detail",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Minimum user",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              SizedBox(
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Limit time",Colors.black,24),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              SizedBox(
                width: 10,
              ),
              text("minute",Colors.black,24),
              SizedBox(
                width: 60,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              SizedBox(
                width: 260,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(164, 151, 134, 1),
                ),
              )
            ],
          ),
        ],
      )),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
