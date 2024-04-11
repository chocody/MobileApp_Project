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
      home: const EventPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.title});

  final String title;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(),
      body: Center(
        child: Column(
          children: [
            banner_event(
                false, "Basketball Court 1", "15:00-17:00", "17 FEB 2024"),
            banner_event(
                true, "Basketball Court 2", "12:00-16:00", "18 FEB 2024"),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
