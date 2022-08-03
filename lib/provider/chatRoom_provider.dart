import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/db/dbHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/message_model.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> messageList = [];

  Future<void> addMessage(String message) {
    final messageModel = MessageModel(
      msgId: DateTime.now().millisecondsSinceEpoch,
      userId: AuthService.user!.uid,
      userName: AuthService.user!.displayName,
      userImage: AuthService.user!.photoURL,
      email: AuthService.user!.email!,
      msg: message,
      timestamp: Timestamp.fromDate(DateTime.now()),
    );
    return DBHelper.addMessage(messageModel);
  }

  getAllChatRoomMessagees() {
    DBHelper.getAllChatRoomMessages().listen((snapshort) {
      messageList = List.generate(snapshort.docs.length,
          (index) => MessageModel.fromMap(snapshort.docs[index].data()));
      notifyListeners();
    });
  }
}
