import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:localization/localization.dart';
import 'package:pdm/theme_manager.dart';
import 'personalData.dart';

import 'config.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Widget get _buildLine {
    return Container(
      color: getTheme().colorScheme.primary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.005,
      alignment: Alignment.topCenter,
    );
  }

  Widget get _buildHistorico {
    return TextButton(
      onPressed: (() => print('historic'.i18n())),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "historic".i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildPedidos {
    return TextButton(
      onPressed: (() => print('request'.i18n())),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'request'.i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildDados {
    return TextButton(
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => dadosPessoais()),
          )),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'data'.i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildChat {
    return TextButton(
      onPressed: (() => print('Chat')),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Chat",
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildPontuacao {
    return TextButton(
      onPressed: (() => print('ratings'.i18n())),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'ratings'.i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildConfig {
    return TextButton(
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfigScreen()),
          )),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'configuration'.i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildFooter {
    return Container(
      color: getTheme().colorScheme.primary,
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
            onPressed: (() => print('configuration'.i18n())),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/pessoa.svg',
            ),
            iconSize: 50,
            onPressed: (() => print('configuration'.i18n())),
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
      backgroundColor: getTheme().colorScheme.primaryContainer,
      body: Stack(children: <Widget>[
        Column(
          children: [
            Container(
              color: getTheme().colorScheme.primary,
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
                        color: getTheme().colorScheme.primary, // border color
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
                                color: getTheme().colorScheme.onPrimary,
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
                              color: getTheme().colorScheme.onPrimary,
                            ),
                          ),
                        ]),
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildConfig,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildHistorico,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildPedidos,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildDados,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildChat,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildPontuacao,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            _buildFooter,
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
