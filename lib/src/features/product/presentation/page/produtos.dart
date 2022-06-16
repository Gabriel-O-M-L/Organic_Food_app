import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class Produtos {
  Produtos({
    required this.P_name,
    required this.P_value,
    required this.P_type,
    required this.P_ratings,
    required this.P_seller,
    required this.P_seller_name,
    required this.P_id,
  });

  String P_name;
  double P_value;
  String P_type;
  double P_ratings;
  int P_seller;
  String P_seller_name;
  int P_id;

  Map<String, dynamic> toJson() {
    return {
      'P_name': P_name,
      'P_value': P_value,
      'P_type': P_type,
      'P_ratings': P_ratings,
      'P_seller': P_seller,
      'P_id': P_id,
    };
  }

  factory Produtos.fromJson(Map<String, dynamic> json) {
    return Produtos(
      P_name: json['P_name'],
      P_value: json['P_value'],
      P_type: json['P_type'],
      P_ratings: json['P_ratings'],
      P_seller: json['P_seller'],
      P_seller_name: json['P_seller_name'],
      P_id: json['P_id'],
    );
  }
}
