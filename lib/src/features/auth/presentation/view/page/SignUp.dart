import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:pdm/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'login.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

Future<http.Response> SignUP(String email, String password) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/create/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password": password,
    }),
  );
}

class _SignUpScreenState extends ModularState<SignUpScreen, LoginViewModel> {
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
        onChanged: (value) => store.email = value,
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
        onChanged: (value) => store.password = value,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          labelText: "password".i18n(),
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

  Widget _buildSignUpTF() {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    return TextButton(
      onPressed: () => _buildSignUpDateTF(),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffFF5252),
        fixedSize: const Size(120, 70),
        primary: Colors.black,
      ),
      child: Text(
        "enter".i18n(),
        style: TextStyle(
          color: Color(0xffFFFFFF),
          fontSize: 22,
        ),
      ),
    );
  }

  Future alertDialog(String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text("warning".i18n(), style: TextStyle(fontSize: 28)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
                  //'Please rate with star',
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _buildSignUpDateTF() async {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    store.password = password;
    store.email = email;

    store.login();

    if (null != store.error.email) {
      String error = store.error.email.toString();
      return alertDialog(error);
    } else if (null != store.error.password) {
      String error = store.error.password.toString();
      return alertDialog(error);
    } else
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

    SignUP(email, password);
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
            Text(
              "register".i18n(),
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
