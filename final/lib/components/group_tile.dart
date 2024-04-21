import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String event_name;
  final String event_description;
  final String event_image;
  final void Function()? onTap;
  final ChatService _chatService = ChatService();
  final bool switchstate;
  final String gid;

  GroupTile({
    super.key,
    required this.event_name,
    required this.event_description,
    required this.event_image,
    required this.onTap,
    required this.switchstate,
    required this.gid,
  });

  @override
  Widget build(BuildContext context) {
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
                image: NetworkImage(event_image),
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
                          event_name,
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
                          event_name,
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
              backgroundColor:
                  Colors.transparent, // Make background transparent
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
                              event_description,
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
                              event_description,
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
                    Switch(
                        value: switchstate,
                        onChanged: (value) {
                          _chatService.switchStatus(gid, value);
                        }),
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

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.amber,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
  //       padding: EdgeInsets.all(20),
  //       child: Row(
  //         children: [
  //           //icon
  //           const Icon(Icons.person),

  //           const SizedBox(width: 20),

  //           // username
  //           Text(text),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
