import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  TextEditingController txtController = TextEditingController();
  static final String id = 'ChatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollection);

  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection(kCollection)
      .orderBy('createdAt', descending: true)
      .snapshots();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (var doc in snapshot.data!.docs) {
              messageList.add(Message.fromJson(doc));
            }
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
                      reverse: true,
                      controller: scrollController,
                      itemCount: snapshot.data!.docs.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(
                                color: kPrimaryColor,
                                message: messageList[index],
                              )
                            : ChatBubbleForFriend(
                                message: messageList[index],
                                color: Colors.deepPurpleAccent,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: TextField(
                      controller: txtController,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'email': email,
                        });
                        txtController.clear();
                        scrollController.animateTo(0,
                            duration: Duration(microseconds: 10),
                            curve: Curves.easeInOut);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            messages.add({
                              'message': txtController.text,
                              'createdAt': DateTime.now(),
                              'email': email,
                            });
                            txtController.clear();
                            scrollController.animateTo(0,
                                duration: Duration(microseconds: 10),
                                curve: Curves.easeInOut);
                          },
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
          } else {
            return ModalProgressHUD(inAsyncCall: true, child: SizedBox());
          }
        });
  }
}
