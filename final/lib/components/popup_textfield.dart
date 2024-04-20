// create pop-up textfeild for join group
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

Future<void> joingroup(BuildContext context) async {
  TextEditingController _controller = TextEditingController();
  ChatService _chat = ChatService();
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Join Group"),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter Group ID."),
          ),
          actions: [
            TextButton(
              child: Text("SUBMIT"),
              onPressed: () async{
                await _chat.joinGroup(_controller.text);
              },
            ),
          ],
        );
      });
}
