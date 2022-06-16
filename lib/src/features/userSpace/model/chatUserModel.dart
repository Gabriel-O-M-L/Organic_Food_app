import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class ChatUserModel {
  ChatUserModel({
    required this.chatId,
    required this.U_id_sender,
    this.name,
    required this.secname,
    required this.U_id_receiver,
    this.text,
  });

  int chatId;
  int U_id_sender;
  int U_id_receiver;
  String? name;
  String secname;
  List<dynamic>? text;

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'U_id_sender': U_id_sender,
      'U_id_receiver': U_id_receiver,
      'name': name,
      'secname': secname,
      'text': text,
    };
  }

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      secname: json['secname'],
      name: json['name'],
      U_id_receiver: json['U_id_receiver'],
      U_id_sender: json['U_id_sender'],
      chatId: json['chatId'],
      text: json['text'],
    );
  }
}
