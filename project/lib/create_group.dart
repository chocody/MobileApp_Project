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
      home: GroupCreatePage(),
    );
  }
}

class GroupCreatePage extends StatefulWidget {

  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: page_bar("Create Group",context),
      body: Center(
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
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2.5,
              ),
            ),
            child: Center(
              child: IconButton(
                onPressed: () => {},
                icon: Icon(Icons.image_outlined,
                    size: 60, color: Color.fromRGBO(188, 190, 192, 1)),
              ),
            ),
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
                "Group name",
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
                "Description",
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
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "Location",
                style: font_page_bar(Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
              Stack(
                children: [
                  Positioned(
                      bottom: 9,
                      right: 9,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                      )),
                  IconButton(
                    onPressed: () => {}, // Handle button press action
                    icon: Icon(Icons.location_on_outlined,
                        size: 25, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 240,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Create",
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
