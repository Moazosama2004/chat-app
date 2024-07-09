import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static final String id = 'ChatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatBubble(
                  color: kPrimaryColor,
                  borderRarius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: kPrimaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
