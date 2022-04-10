import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:localization/localization.dart';
import "package:pdm/src/features/auth/presentation/viewmodel/login_viewmodel.dart";
import 'package:pdm/theme_manager.dart';

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

class _ForgetPassword extends ModularState<ForgetPassword, LoginViewModel> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String email = "";
  String password = "";

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

  Widget get _buildEmailTF {
    email = emailController.text;
    return SizedBox(
      width: 300,
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(color: getTheme().colorScheme.onTertiary),
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
            fontSize: 22,
            color: getTheme().colorScheme.onTertiary,
          ),
          filled: true,
          fillColor: getTheme().colorScheme.tertiary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: getTheme().colorScheme.tertiary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildPasswordTF {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        autofocus: false,
        style: TextStyle(color: getTheme().colorScheme.onTertiary),
        decoration: InputDecoration(
          labelText: "new_password".i18n(),
          labelStyle: TextStyle(
            color: getTheme().colorScheme.onTertiary,
            fontSize: 22,
          ),
          filled: true,
          fillColor: getTheme().colorScheme.tertiary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: getTheme().colorScheme.tertiary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildSignUpTF {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    return TextButton(
      onPressed: () => _buildResetPasswordTF(),
      style: TextButton.styleFrom(
        backgroundColor: getTheme().colorScheme.secondary,
        fixedSize: const Size(180, 70),
        primary: Colors.black,
      ),
      child: Text(
        "password_reset".i18n(),
        style: TextStyle(
          color: getTheme().colorScheme.onSecondary,
          fontSize: 18,
        ),
      ),
    );
  }

  Future _buildResetPasswordTF() async {
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

    forgetPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme().colorScheme.primaryContainer,
      body: Stack(children: <Widget>[
        Column(
          children: [
            Container(
              color: getTheme().colorScheme.primary,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 50),
            Text(
              "reset_password".i18n(),
              style: TextStyle(
                fontSize: 28,
                color: getTheme().colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 80),
            _buildEmailTF,
            const SizedBox(height: 30),
            _buildPasswordTF,
            const SizedBox(height: 50),
            _buildSignUpTF,
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
