import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;
  final String imgpath;

  const UserTile({
    super.key,
    required this.text,
    required this.imgpath,
    });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
          ],
        ),
      ),
    );
  }
  
}