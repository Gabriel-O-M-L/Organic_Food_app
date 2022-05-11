import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toddy/ResetPassoword.dart';
import 'package:toddy/SignUp.dart';
import 'package:toddy/login.dart';
import 'package:http/http.dart' as http;
import 'package:toddy/pesquisa.dart';
import 'package:toddy/teste.dart';

import 'SignUp.dart';
import 'config.dart';
import 'dadospessoais.dart';
import 'map.dart';
import 'onboarding.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen02(),
    );
  }
}
