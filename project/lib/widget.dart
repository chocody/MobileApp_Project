import 'package:flutter/material.dart';

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
      IconButton(
          onPressed: () => {Navigator.of(context).pushNamed("create_event")},
          icon: const Icon(Icons.search)),
      Container(
          width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
      IconButton(
          onPressed: () => {
                {Navigator.of(context).pushNamed("create_group")}
              },
          icon: const Icon(Icons.home)),
      Container(
          width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
      IconButton(
          onPressed: () => {
                {Navigator.of(context).pushNamed("event")}
              },
          icon: const Icon(Icons.notifications)),
    ],
  );
}

AppBar page_bar(page_name, context) {
  String page = page_name;

  return AppBar(
    toolbarHeight: 80,
    backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
    leading: Row(
      children: [
        IconButton(
          onPressed: () => {Navigator.of(context).pushNamed("event")},
          icon: Icon(
            Icons.arrow_left,
            size: 60,
            color: Colors.white,
          ),
        ),
      ],
    ),
    leadingWidth: 80,
    title: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        text(page, Colors.white, 24),
      ],
    ),
  );
}

Expanded textformfield(guide_text,controller) {
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

GestureDetector banner_event(join, group_name, set_time, event_date, context) {
  Color status_color =
      join ? Color.fromRGBO(123, 229, 7, 1) : Color.fromRGBO(255, 69, 84, 1);
  IconData status_icon =
      join ? Icons.check_circle_outline : Icons.cancel_outlined;
  String name = group_name;
  String time = set_time;
  String date = event_date;

  return GestureDetector(
    onTap: () => {Navigator.of(context).pushNamed("event_detail")},
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
