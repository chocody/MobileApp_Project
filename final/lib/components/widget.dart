import 'package:demo_chat/components/popup_textfield.dart';
import 'package:demo_chat/pages/chat_page.dart';
import 'package:demo_chat/pages/creategroup_page.dart';
import 'package:demo_chat/pages/eventinfo_page.dart';
import 'package:demo_chat/pages/eventlist_page.dart';
import 'package:demo_chat/pages/home_page.dart';
import 'package:demo_chat/pages/profile_page.dart';
import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

void toHomePage(BuildContext context) {
  // go to profile page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
}

// void toChatPage(BuildContext context) {
//   // go to profile page
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatPage(),
//       ));
// }

void toProfilePage(BuildContext context) {
  // go to profile page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ));
}

void toCreateGroupPage(BuildContext context) {
  // go to create group page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGroupPage(),
      ));
}

void toEventListPage(BuildContext context) {
  // go to evenlist page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(),
      ));
}

void toEventInfoPage(BuildContext context) {
  // go to evenlist page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventInfoPage(),
      ));
}

void logout() {
  //get auth service
  final _auth = AuthService();
  _auth.signOut();
}

Text text(input_text, font_color, font_size) {
  String text = input_text;
  return Text(
    text,
    style: font_page_bar(font_color, font_size),
  );
}

TextStyle font_page_bar(font_color, font_size) {
  double size = font_size.toDouble();
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: font_color,
  );
}

AppBar nav_bar(context) {
  return AppBar(
    toolbarHeight: 60,
    backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
    leading: IconButton(
        onPressed: () => toProfilePage(context), icon: Icon(Icons.person)),
    actions: [
      IconButton(
          onPressed: () => joingroup(context), icon: const Icon(Icons.search)),
      Container(
          width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
      IconButton(
          onPressed: () => toHomePage(context), icon: const Icon(Icons.home)),
      Container(
          width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
      IconButton(
          onPressed: () => toEventListPage(context),
          icon: const Icon(Icons.notifications)),
    ],
  );
}

AppBar page_bar(page_name, context) {
  String page = page_name;

  return AppBar(
    toolbarHeight: 80,
    iconTheme: IconThemeData(color: Colors.white, size: 30),
    backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
    title: Row(
      children: [
        text(page, Colors.white, 24),
      ],
    ),
  );
}

Expanded textformfield(guide_text, controller) {
  String text = guide_text;
  return Expanded(
      child: SizedBox(
    height: 30,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.5),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  ));
}

SizedBox person_tile(name) {
  String text = name;
  return SizedBox(
    width: 300,
    child: ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage('assets/picture/jane.png'),
      ),
      title: Text(text),
      tileColor: Color.fromRGBO(214, 191, 175, 1),
    ),
  );
}

GestureDetector banner_event(
    join, event_name, event_time, event_date, count, event_img, context) {
  Color status_color =
      join ? Color.fromRGBO(123, 229, 7, 1) : Color.fromRGBO(255, 69, 84, 1);
  IconData status_icon =
      join ? Icons.check_circle_outline : Icons.cancel_outlined;

  String name = event_name;
  String time = event_time;
  String date = event_date;
  String img = event_img;

  int no = count;

  return GestureDetector(
    onTap: () => toEventInfoPage(context),
    // onTap: () => {
    //   Navigator.of(context).pushNamed(
    //     "event_detail",
    //     arguments: no,
    //   ),
    // },
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
          child: MaterialBanner(
            padding: EdgeInsets.all(20.0), // Inner padding
            content: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black,
                  ),
                ),
                // Solid text as fill.
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
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
                  Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            time,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            time,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
    ),
  );
}

GestureDetector banner_group(
  group_name, event_description, count, event_img, context) {
  String name = group_name;
  String description = event_description;
  String img = event_img;

  int no = count;


  return GestureDetector(
    onTap: () => {},
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
          child: MaterialBanner(
            padding: EdgeInsets.all(20.0), // Inner padding
            content: Row(children: [
              Row(
                children: [
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.black,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
            backgroundColor: Colors.transparent, // Make background transparent
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 90,
                      ),
                      Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            description,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            description,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
    //               Switch(
    //   value: isSwitched,
    //   onChanged: _toggleSwitch,
    //   activeTrackColor: Colors.lightGreenAccent,
    //   activeColor: Colors.green,
    // ),
                  SizedBox(
                    width: 220,
                  ),
                  Stack(children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.access_alarm,
                      color: Colors.white,
                      size: 30,
                    ),
                  ]),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
