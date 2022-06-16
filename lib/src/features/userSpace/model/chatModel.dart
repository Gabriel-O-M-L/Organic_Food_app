import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class ChatModel {
  ChatModel({
    required this.msg,
    required this.pos,
  });

  String msg;
  int pos;

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'pos': pos,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      msg: json['msg'],
      pos: json['pos'],
    );
  }
}
