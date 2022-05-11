import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toddy/ResetPassoword.dart';
import 'package:toddy/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:toddy/pesquisa.dart';
import 'package:toddy/user.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  Widget _buildLine() {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.005,
      alignment: Alignment.topCenter,
    );
  }

  Widget _buildTrocarSenha() {
    return TextButton(
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgetPassword()),
          )),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Trocar Senha",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildNotificacao() {
    return TextButton(
      onPressed: (() => print('Notificação')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Notificação",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildTema() {
    return TextButton(
      onPressed: (() => print('Tema')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Tema",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildTrocarEmail() {
    return TextButton(
      onPressed: (() => print('Trocar Email')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Trocar Email",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: const Color(0xff388E3C),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/casa.svg',
            ),
            iconSize: 50,
            onPressed: (() => print('config')),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/pessoa.svg',
            ),
            iconSize: 50,
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                )),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/lupa.svg',
            ),
            iconSize: 50,
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                )),
          )
        ],
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
              height: MediaQuery.of(context).size.height * 0.08,
              alignment: Alignment.topCenter,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          "Configurações",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 2, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 20),
            _buildTrocarSenha(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildNotificacao(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildTema(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildTrocarEmail(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
