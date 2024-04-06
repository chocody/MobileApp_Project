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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nav_bar(),
      body: Center(
        child: Column(
          children: [
            banner_event(false),
            banner_event(true),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }

  AppBar nav_bar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
      leading: const Row(
        children: [
          SizedBox(width: 10.0),
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/picture/jane.png'),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
        Container(
            width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.home)),
        Container(
            width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications)),
      ],
    );
  }

  Padding banner_event(join) {
    Color status_color =
        join ? Color.fromRGBO(123, 229, 7, 1) : Color.fromRGBO(255, 69, 84, 1);
    IconData status_icon = join ? Icons.check_circle_outline : Icons.cancel_outlined;

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: const DecorationImage(
              image: AssetImage('assets/picture/court1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: MaterialBanner(
            padding: EdgeInsets.all(20.0), // Inner padding
            content: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'Basketball Court 1',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black,
                  ),
                ),
                // Solid text as fill.
                Text(
                  'Basketball Court 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent, // Make background transparent
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        '13:00-15:00',
                        style: TextStyle(
                          fontSize: 30,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.black,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        '13:00-15:00',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Stack(children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status_color,
                  ),
                ),
                Icon(
                  status_icon,
                  color: Colors.white,
                  size: 30,
                ),
              ]),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
