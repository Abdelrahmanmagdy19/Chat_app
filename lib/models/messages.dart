import 'package:chat_app/widgets/constants.dart';

class Message {
  final String id;
  final String message;
  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
