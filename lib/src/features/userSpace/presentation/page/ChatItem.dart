import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdm/src/features/userSpace/model/chatUserModel.dart';
import 'package:pdm/src/features/userSpace/presentation/page/sendchat.dart';
import 'package:pdm/theme_manager.dart';
import 'package:http/http.dart' as http;

class ChatItem extends StatelessWidget {
  ChatItem({
    Key? key,
    this.token,
    this.email,
    required this.userChat,
  }) : super(key: key);

  final String? token;
  final String? email;
  final ChatUserModel userChat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        print("onDoubleTap " + userChat.secname);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendChatScreen(
              token: token,
              email: email,
              userChat: userChat,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: getTheme().colorScheme.primary,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(Icons.message,
                    size: 70.0, color: getTheme().colorScheme.onPrimary),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userChat.secname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: getTheme().colorScheme.onPrimary),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
