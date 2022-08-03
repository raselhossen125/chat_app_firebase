// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:chat_app_firebase/provider/chatRoom_provider.dart';
import 'package:chat_app_firebase/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  static const routeName = '/chat';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final messageController = TextEditingController();
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<ChatRoomProvider>(context, listen: false).getAllChatRoomMessagees();
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ChatRoomProvider>(
          builder: (context, provider, _) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: provider.messageList.length,
                  itemBuilder: (context, index) {
                    final msg = provider.messageList[index];
                    return MessageItem(messageModel: msg);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.addMessage(messageController.text);
                        messageController.clear();
                      },
                      icon: Icon(Icons.send),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
