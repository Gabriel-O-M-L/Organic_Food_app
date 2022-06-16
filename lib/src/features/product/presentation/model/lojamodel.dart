import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class Loja {
  Loja({
    required this.S_name,
    required this.S_id,
  });

  // factory Produtos.fromJson(Map<String, dynamic> parsedJson) {
  //   return Produtos(
  //       P_name: parsedJson['P_name'].toString(),
  //       P_value: parsedJson['P_value'],
  //       P_type: parsedJson['P_type'].toString(),
  //       P_ratings: parsedJson['P_value'],
  //       P_seller: parsedJson['P_seller']);
  // }

  // Produtos.fromJson(Map<dynamic, dynamic> json)
  //     : P_name = json['P_name'],
  //       P_value = double.parse(json['P_value']),
  //       P_type = json['P_type'],
  //       P_ratings = double.parse(json['P_ratings']),
  //       P_seller = int.parse(json['P_seller']);
  String S_name;
  int S_id;

  Map<String, dynamic> toJson() {
    return {
      'S_name': S_name,
      'S_id': S_id,
    };
  }

  factory Loja.fromJson(Map<String, dynamic> json) {
    return Loja(
      S_name: json['S_name'],
      S_id: json['S_id'],
    );
  }
}
