import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'login.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPassword createState() => _ForgetPassword();
}

Future<http.Response> forgetPassword(String email, String password) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/forgot/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password": password,
    }),
  );
}

class _ForgetPassword extends State<ForgetPassword> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String email = "";
  String password = "";

  Widget _buildEmailTF() {
    email = emailController.text;
    return SizedBox(
      width: 300,
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
            fontSize: 22,
            color: Color(0xffFFFFFF),
          ),
          filled: true,
          fillColor: Color(0xffBDBDBD),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Color(0xffBDBDBD),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          labelText: "New Password",
          labelStyle: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 22,
          ),
          filled: true,
          fillColor: Color(0xffBDBDBD),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Color(0xffBDBDBD),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpTF() {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    return TextButton(
      onPressed: () => _buildResetPasswordTF(),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffFF5252),
        fixedSize: const Size(180, 70),
        primary: Colors.black,
      ),
      child: const Text(
        "Reset Passoword",
        style: TextStyle(
          color: Color(0xffFFFFFF),
          fontSize: 18,
        ),
      ),
    );
  }

  void _buildResetPasswordTF() {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    forgetPassword(email, password);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Column(
          children: [
            Container(
              color: const Color(0xff388E3C),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 50),
            const Text(
              "Reset your password",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xff212121),
              ),
            ),
            const SizedBox(height: 80),
            _buildEmailTF(),
            const SizedBox(height: 30),
            _buildPasswordTF(),
            const SizedBox(height: 50),
            _buildSignUpTF(),
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}