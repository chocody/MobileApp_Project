import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventTile extends StatelessWidget {
  final String event_name;
  final String event_date;
  final String event_time;
  final String event_img;
  final bool event_status;
  final void Function()? onTap;
  const EventTile({
    super.key,
    required this.onTap,
    required this.event_name,
    required this.event_date,
    required this.event_time,
    required this.event_img, required this.event_status,
  });

  @override
  Widget build(BuildContext context) {
    Color status_color =
      event_status ? Color.fromRGBO(123, 229, 7, 1) : Color.fromRGBO(255, 69, 84, 1);
  IconData status_icon =
      event_status ? Icons.check_circle_outline : Icons.cancel_outlined;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                image: NetworkImage(event_img),
                fit: BoxFit.cover,
              ),
            ),
            child: MaterialBanner(
              padding: EdgeInsets.all(20.0), // Inner padding
              content: Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    event_name,
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
                    event_name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              backgroundColor:
                  Colors.transparent, // Make background transparent
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
                              event_time,
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
                              event_time,
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
                              event_date,
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
                              event_date,
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
}
