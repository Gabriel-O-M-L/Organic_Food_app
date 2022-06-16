import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/userSpace/presentation/page/personalData.dart';

void main() async {
  runApp(MaterialApp(
    home: dadosPessoais(
      token:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHAiOjE2NTU4MzI4MzMzNzEuNTE2OH0.b9e8t05WjwFLCUIulKq_Gs1Paa7GE6cCrik5cnf09Co",
      email: "toddy@toddy.com.br",
    ),
  ));
}
