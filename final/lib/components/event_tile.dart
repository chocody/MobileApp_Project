import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const EventTile({
    super.key,
    required this.text,
    required this.onTap,
    });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            //icon
            const Icon(Icons.person),

            const SizedBox(width: 20),

            // username
            Text(text),
          ],
        ),
      ),
    );
  }
  
}