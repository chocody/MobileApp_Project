import 'package:demo/create_event.dart';
import 'package:demo/create_group.dart';
import 'package:demo/event_detail_page.dart';
import 'package:demo/event.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: EventPage(),
        routes: <String, WidgetBuilder>{
          "event": (BuildContext context) => EventPage(),
          "create_event": (BuildContext context) => EventCreatePage(),
          "create_group": (BuildContext context) => GroupCreatePage(),
          "event_detail": (BuildContext context) => EventDetailPage(),
        });
  }
}
