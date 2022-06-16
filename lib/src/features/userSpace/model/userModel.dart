import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  String email;
  String name;
  String phone;
  double latitude;
  double longitude;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
