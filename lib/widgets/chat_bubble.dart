import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, required this.color, required this.borderRarius,
  });


  final Color color;
  final BorderRadius borderRarius;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16 , vertical: 16 ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRarius
        ),
        child: Text(
          'Hello i\'m Moaz Osama Ahmefsdfsdfsdfsdf ',
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}