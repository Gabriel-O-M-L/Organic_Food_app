import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toddy/ResetPassoword.dart';
import 'package:toddy/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:toddy/pesquisa.dart';

import 'config.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Widget _buildLine() {
    return Container(
      color: const Color(0xff388E3C),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.005,
      alignment: Alignment.topCenter,
    );
  }

  Widget _buildHistorico() {
    return TextButton(
      onPressed: (() => print('Histório de Compras')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Histório de Compras",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildPedidos() {
    return TextButton(
      onPressed: (() => print('Pedidos')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Pedidos",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildDados() {
    return TextButton(
      onPressed: (() => print('Dados')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Dados",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildChat() {
    return TextButton(
      onPressed: (() => print('Chat')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Chat",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildPontuacao() {
    return TextButton(
      onPressed: (() => print('Pontuação')),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Pontuação",
        style: TextStyle(
          color: Color(0xff212121),
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildConfig() {
    return TextButton(
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfigScreen()),
          )),
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Configurações",
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
            onPressed: (() => print('config')),
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
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.topCenter,
              child: Column(children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.25), // border color
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2), // border width
                        child: Container(
                          // or ClipRRect if you need to clip the content
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            // inner circle color
                          ),
                          child: Container(), // inner content
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              "Nome: TESTE",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 110,
                            ),
                          ]),
                          const SizedBox(height: 10),
                          Text(
                            'Email: teste@teste.com',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildConfig(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildHistorico(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildPedidos(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildDados(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildChat(),
            const SizedBox(height: 20),
            _buildLine(),
            const SizedBox(height: 20),
            _buildPontuacao(),
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
