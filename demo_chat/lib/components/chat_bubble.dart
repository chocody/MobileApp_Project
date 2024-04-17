import "package:flutter/material.dart";

class ChatBubble extends StatelessWidget{
  final String message;
  final bool isCurrentUser;

  ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.amber : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
    );
  }
}