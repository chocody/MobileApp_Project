
import 'package:demo_chat/pages/create_event.dart';
import 'package:demo_chat/pages/create_group.dart';
import 'package:demo_chat/pages/event.dart';
import 'package:demo_chat/pages/event_detail_page.dart';
import 'package:demo_chat/pages/home_page.dart';
import 'package:demo_chat/services/auth/auth_gate.dart';
import 'package:flutter/services.dart';
import 'package:demo_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    name: "dev project",
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
      home: const AuthGate(),
      routes: <String, WidgetBuilder>{
          "event": (BuildContext context) => EventPage(),
          "create_event": (BuildContext context) => EventCreatePage(),
          "create_group": (BuildContext context) => GroupCreatePage(),
          "event_detail": (BuildContext context) => EventDetailPage(),
          "home": (BuildContext context) => HomePage(),
        });
  }

}