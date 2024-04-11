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
                width: 10,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Event name",
                style: font_page_bar(Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 40,
                width: 20,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  controller: TextEditingController(),
                ),
              )),
            ],
          ),
        ],
      )),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
