import 'package:flutter/material.dart';

TextStyle font_page_bar(font_color) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: font_color,
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

AppBar page_bar(page_name) {
  String page = page_name;

  return AppBar(
    toolbarHeight: 80,
    backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
    leading: Row(
      children: [
        IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.arrow_left,
            size: 60,
            color: Colors.white,
          ),
        ),
      ],
    ),
    leadingWidth: 80,
    title: Text(
      page,
      style: font_page_bar(Colors.white),
    ),
  );
}

Expanded textfield(guide_text) {
  String text = guide_text;
  return Expanded(
      child: SizedBox(
    height: 30,
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.5),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      controller: TextEditingController(),
    ),
  ));
}

GestureDetector banner_event(join, group_name, set_time, event_date) {
  Color status_color =
      join ? Color.fromRGBO(123, 229, 7, 1) : Color.fromRGBO(255, 69, 84, 1);
  IconData status_icon =
      join ? Icons.check_circle_outline : Icons.cancel_outlined;
  String name = group_name;
  String time = set_time;
  String date = event_date;

  return GestureDetector(
    onTap: () => {},
    child: Padding(
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
