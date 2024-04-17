import 'package:demo/create_event.dart';
import 'package:demo/create_group.dart';
import 'package:demo/event.dart';
import 'package:demo/event_detail_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
