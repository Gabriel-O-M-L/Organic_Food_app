import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/userSpace/model/chatModel.dart';
import 'package:pdm/src/features/userSpace/model/chatUserModel.dart';
import 'package:pdm/src/features/userSpace/widget/chatBubble.dart';
import 'package:pdm/theme_manager.dart';
import 'dart:convert';

class SendChatScreen extends StatefulWidget {
  final String? token;
  final String? email;
  final ChatUserModel? userChat;

  const SendChatScreen({
    Key? key,
    this.token,
    this.email,
    this.userChat,
  }) : super(key: key);
  @override
  _SendChatScreenState createState() =>
      _SendChatScreenState(token, email, userChat);
}

class _SendChatScreenState extends State<SendChatScreen> {
  TextEditingController msgController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final String? token;
  final String? email;
  String? msgLimpa;
  final ChatUserModel? userChat;
  List<ChatModel> message = [];
  List<String> msgBrutaList = [];
  String? msgBruta;
  ChatUserModel? User;

  _SendChatScreenState(this.token, this.email, this.userChat);

  void initState() {
    super.initState();

    setState(() {
      getUserChat(userChat!.chatId);
    });
  }

  void separarString(String text) {
    List<String> char = [];
    char = text.split("");
    String posStr = char[char.length - 1];
    String msg = text.replaceAll(posStr, "");
    int pos = int.parse(posStr);
    print("pos: " + posStr);
    print("msg: " + msg);
    ChatModel msgUserNew = new ChatModel(
      msg: msg,
      pos: pos,
    );
    message.add(msgUserNew);
  }

  Future<http.Response> sendMsg(String text) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/chat/send/');

    Map data = {
      "jwt": token,
      "U_id_sender": userChat!.U_id_sender,
      "U_id_receiver": userChat!.U_id_receiver,
      "text": text,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Msg Enviada Ok!" + text);
      getUserChat(userChat!.chatId);
    } else
      print("Msg Enviada Error!");

    return response;
  }

  Future<ChatUserModel?> getUserChat(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/chat/getchat/');

    Map data = {
      "chat_id": id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      User = ChatUserModel.fromJson(jsonDecode(response.body));

      msgBruta = User!.text!.join('|');
      print("msgBruta: " + msgBruta!);

      msgBrutaList = msgBruta!.split('|');

      setState(() {
        message.clear();
        for (String text in msgBrutaList) {
          separarString(text);
        }
      });

      print("GetUser sucesso!");

      return ChatUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('GetUser Error');
    }
  }

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
        title: Text(userChat!.secname),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                // controller: _scrollController,
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
                        hintText: "Enviar_Mensagem".i18n(),
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
                              // _scrollController.jumpTo(
                              //     _scrollController.position.maxScrollExtent);
                              for (ChatModel x in message) {
                                print("message: " + x.msg);
                              }
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
