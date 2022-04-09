import 'dart:convert';
import 'dart:developer';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'ResetPassoword.dart';
import 'SignUp.dart';
import '../../../../onboarding/presentation/page/onboarding.dart';
import 'package:pdm/src/features/auth/presentation/view/page/ResetPassoword.dart';
import 'package:localization/localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ModularState<LoginScreen, LoginViewModel> {
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
          title: Text('warning'.i18n(), style: TextStyle(fontSize: 28)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
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

  Widget _buildEmailTF() {
    email = emailController.text;
    return SizedBox(
      width: 300,
      child: TextFormField(
        validator: (value) {
          store.email = email;
          store.login();
          if (null != store.error.email) {
            String error = store.error.email.toString();
            return error;
          }
          return null;
        },
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
      child: TextFormField(
        validator: (value) {
          store.password = password;
          store.login();
          if (null != store.error.password) {
            String error = store.error.password.toString();
            return error;
          }
          return null;
        },
        controller: passwordController,
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

  String _buildSignUpTF() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );

    return '$email, $password';
  }

  String _buildResetPasswordTF() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgetPassword()),
    );

    return '$email, $password';
  }

  Future<Object?> _buildLoginDateTF() async {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    var url = Uri.parse('http://127.0.0.1:8000/api/login/');
    var response = await http
        .post(url, body: {'email': '$email', 'password': '$password'});

    if (email.length < 5) {
      return alertDialog("short_email".i18n());
    } else if (!email.contains("@")) {
      alertDialog("invalid_email".i18n());
    } else if (password.length < 6) {
      return alertDialog("short_password".i18n());
    } else if (response.statusCode == 202)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserScreen()),
      );
    else
      alertDialog("incorrect_data".i18n());
  }

  Widget _buildLoginTF() {
    email = emailController.text.toString();
    password = passwordController.text.toString();

    return TextButton(
      onPressed: () => print(_buildLoginDateTF()),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffFF5252),
        fixedSize: const Size(90, 40),
        primary: Colors.black,
      ),
      child: Text(
        "acess".i18n(),
        style: TextStyle(
          color: Color(0xffFFFFFF),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSignupTF() {
    return TextButton(
      onPressed: () => print(_buildSignUpTF()),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffFF5252),
        fixedSize: const Size(90, 40),
        primary: Colors.black,
      ),
      child: Text(
        "register".i18n(),
        style: TextStyle(
          color: Color(0xffFFFFFF),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildForgetPasswordTF() {
    return TextButton(
      onPressed: (() => _buildResetPasswordTF()),
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: Text(
        "forgot_password".i18n(),
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 16,
        ),
      ),
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
            Container(
              height: 120,
              width: 120,
              margin: const EdgeInsets.all(30),
              child: SvgPicture.asset(
                'lib/assets/images/leaf.svg',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Horti em Casa",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xff212121),
              ),
            ),
            const SizedBox(height: 80),
            _buildEmailTF(),
            const SizedBox(height: 30),
            _buildPasswordTF(),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLoginTF(),
              const SizedBox(width: 120),
              _buildSignupTF(),
            ]),
            const SizedBox(height: 30),
            _buildForgetPasswordTF(),
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
