import 'package:demo/widget.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(context),
      body: Center(
        child: Column(
          children: [
            banner_event(false, "Basketball Court 1", "15:00-17:00",
                "17 FEB 2024", context),
            banner_event(true, "Basketball Court 2", "12:00-16:00",
                "18 FEB 2024", context),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
