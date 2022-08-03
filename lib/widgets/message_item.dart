import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/model/message_model.dart';
import 'package:chat_app_firebase/utils/helper_function.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;

  MessageItem({required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: messageModel.userId == AuthService.user!.uid
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(messageModel.userName ?? messageModel.email),
            Text(getFormatedDate(messageModel.timestamp.toDate())),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(messageModel.msg, style: TextStyle(fontSize: 16, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
