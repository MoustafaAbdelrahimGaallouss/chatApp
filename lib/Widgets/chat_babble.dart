import 'package:chat_app/constants.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:flutter/material.dart';

class chatBubble extends StatelessWidget {
   const chatBubble({
    super.key,
    required this.massage,
  });
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: kPrimaryColor,
          ),
          child: Text(massage.content,
              style: const TextStyle(
                color: Colors.white,
              ))),
    );
  }
}



class chatBubbleForFriend extends StatelessWidget {
   const chatBubbleForFriend({
    super.key,
    required this.massage,
  });
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Color(0xff006D84),
          ),
          child: Text(massage.content,
              style: const TextStyle(
                color: Colors.white,
              ))),
    );
  }
}
