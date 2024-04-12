import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(164, 151, 134, 1)),
        useMaterial3: true,
      ),
      home: const EventCreatePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class EventCreatePage extends StatefulWidget {
  const EventCreatePage({super.key, required this.title});

  final String title;

  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: page_bar("Create Event"),
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
              Text(
                "Event name",
                style: font_page_bar(Colors.black),
              ),
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
              Text(
                "Date",
                style: font_page_bar(Colors.black),
              ),
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
              Text(
                "Time",
                style: font_page_bar(Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              Text(
                " : ",
                style: font_page_bar(Colors.black),
              ),
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
              Text(
                "Detail",
                style: font_page_bar(Colors.black),
              ),
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
              Text(
                "Minimum user",
                style: font_page_bar(Colors.black),
              ),
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
              Text(
                "Limit time",
                style: font_page_bar(Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              textfield(""),
              SizedBox(
                width: 10,
              ),
              Text(
                "minute",
                style: font_page_bar(Colors.black),
              ),
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
