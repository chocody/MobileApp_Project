import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:flutter/material.dart';

class EventCreatePage extends StatefulWidget {
  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {
  
  var eventnameController = new TextEditingController();
  var dateController = new TextEditingController();
  var time1Controller = new TextEditingController();
  var time2Controller = new TextEditingController();
  var detailController = new TextEditingController();
  var minuserController = new TextEditingController();
  var limitController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: page_bar("Create Event", context),
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
              text("Event name", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", eventnameController),
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
              text("Date", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("DD/MM/YYYY", dateController),
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
              text("Time", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", time1Controller),
              text(" : ", Colors.black, 24),
              textformfield("", time2Controller),
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
              text("Detail", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", detailController),
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
              text("Minimum user", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", minuserController),
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
              text("Limit time", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", limitController),
              SizedBox(
                width: 10,
              ),
              text("minute", Colors.black, 24),
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
                onPressed: () {
                  firestore.collection("Event Detail").add({
                    "Event name": eventnameController.text,
                    "Date": dateController.text,
                    "Time": "${time1Controller.text}-${time2Controller.text}",
                    "Detail": detailController.text,
                    "Minimum User": minuserController.text,
                    "Limit time": limitController.text,
                    "Users":[],
                  });
                  Navigator.of(context).pop();
                  eventnameController.clear();
                  dateController.clear();
                  time1Controller.clear();
                  time2Controller.clear();
                  detailController.clear();
                  minuserController.clear();
                  limitController.clear();
                },
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
