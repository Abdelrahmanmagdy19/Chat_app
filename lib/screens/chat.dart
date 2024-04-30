import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/chat_buble.dart';

class ChatPgae extends StatelessWidget {
  ChatPgae({super.key});
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kprimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 55,
                  ),
                  Text(liveChat),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageslist.length,
                    itemBuilder: (context, index) {
                      return messageslist[index].id == email
                          ? ChatBuble(
                              message: messageslist[index],
                            )
                          : ChatBubleForFriend(message: messageslist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Meassge',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: kprimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('loading.....');
        }
      },
    );
  }
}
