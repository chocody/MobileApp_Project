import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String imgpath;
  final double u_latitude;
  final double u_longtitude;
  final bool enable;
  final double g_latitude;
  final double g_longtitude;

  const UserTile({
    super.key,
    required this.text,
    required this.imgpath,
    required this.u_latitude,
    required this.u_longtitude,
    required this.enable,
    required this.g_latitude,
    required this.g_longtitude,
  });

  @override
  Widget build(BuildContext context) {
    Color color_tile;
    // print(u_latitude);
    // print(g_latitude);
    // print(u_longtitude);
    // print(g_longtitude);
    if (enable == true) {
      if (u_latitude >= g_latitude - 0.000200 &&
          u_latitude <= g_latitude + 0.000200 &&
          u_longtitude <= g_longtitude + 0.000200 &&
          u_longtitude >= g_longtitude - 0.000200) {
        color_tile = Colors.green;
      } else {
        color_tile = Colors.grey;
      }
    } else {
      color_tile = Colors.grey;
    }
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: color_tile,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            //profile
            CircleAvatar(
              backgroundImage: NetworkImage(imgpath),
              radius: 20,
            ),

            const SizedBox(width: 20),

            // username
            Text(
              text,
            ),

            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
