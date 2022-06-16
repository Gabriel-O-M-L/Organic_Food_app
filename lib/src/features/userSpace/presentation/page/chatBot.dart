import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/userSpace/model/chatModel.dart';
import 'package:pdm/src/features/userSpace/widget/chatBubble.dart';
import 'package:pdm/theme_manager.dart';
import 'dart:convert';

class ChatBotScreen extends StatefulWidget {
  final String? token;
  final String? email;

  const ChatBotScreen({
    Key? key,
    this.token,
    this.email,
  }) : super(key: key);
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState(token, email);
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController msgController = new TextEditingController();
  final String? token;
  final String? email;
  String? msgLimpa;
  List<ChatModel> message = [];
  List<ChatModel> messageRev = [];

  _ChatBotScreenState(this.token, this.email);

  Future<http.Response> sendMsg(String msg) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/chat/sendBot/');

    Map data = {
      "jwt": token,
      "user_message": msg,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");
    msgLimpa = response.body;
    msgLimpa = msgLimpa!.replaceAll('{"fulfilment_text":"', '');
    msgLimpa = msgLimpa!.replaceAll('"}', '');
    print(msgLimpa);

    if (response.statusCode == 200) {
      ChatModel msgOther = new ChatModel(msg: msgLimpa!, pos: 0);

      setState(() {
        message.add(msgOther);
      });
      print("Chat OK!");
    } else {
      print("Chat Error!");
    }

    return response;
  }

  // void reverseList(List<ChatModel> chat) {
  //   print("**reverse***");
  //   if (message.isNotEmpty) {
  //     for (int x = chat.length - 1; x > 0; x--) {
  //       messageRev.insert(0, chat[x]);
  //     }
  //     // for (int x = chat.length; x > 0; x--) {
  //     //   message.insert(0, chat[x]);
  //     // }
  //     for (ChatModel m in messageRev) {
  //       print("teste: " + m.msg);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: getTheme().colorScheme.primary,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: Text("Chat_Bot".i18n()),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                reverse: false,
                children: [
                  for (ChatModel chat in message)
                    ChatBubble(
                      message: chat.msg,
                      data: chat.pos,
                    ),
                ],
              ),
            ),
            Divider(
              height: 6.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: msgController,
                    decoration: InputDecoration.collapsed(
                        hintText: "Enviar Mensagem",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                        ),
                        onPressed: () {
                          if (msgController.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              ChatModel msgUser = new ChatModel(
                                msg: msgController.text,
                                pos: 1,
                              );
                              sendMsg(msgController.text);

                              message.add(msgUser);
                              // reverseList(message);
                              msgController.clear();
                            });
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: getTheme().colorScheme.primary,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
    );
  }
}
