import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/auth/presentation/view/page/ResetPassoword.dart';
import 'package:localization/localization.dart';
import 'package:pdm/theme_manager.dart';

import '../../../auth/presentation/view/page/login.dart';

class ConfigScreen extends StatefulWidget {
  final String? token;
  final String? email;

  const ConfigScreen({Key? key, this.token, this.email}) : super(key: key);
  @override
  _ConfigScreenState createState() => _ConfigScreenState(token, email);
}

class _ConfigScreenState extends State<ConfigScreen> {
  final String? token;
  final String? email;

  _ConfigScreenState(this.token, this.email);
  Widget get _buildLine {
    return Container(
      color: getTheme().colorScheme.primary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.005,
      alignment: Alignment.topCenter,
    );
  }

  Widget get _buildTrocarSenha {
    return TextButton(
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ForgetPassword(token: token, email: email)),
          )),
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'change_password'.i18n(),
        style: TextStyle(
          color: getTheme().colorScheme.onPrimaryContainer,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildNotificacao {
    return TextButton(
      onPressed: (() => print('Notificação')),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "notification".i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildTema {
    return TextButton(
      onPressed: (() {
        changeTheme();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfigScreen(),
            ));
      }),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "theme".i18n(),
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget get _buildTrocarEmail {
    return TextButton(
      onPressed: (() => print('Trocar Email')),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "change_email".i18n(),
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
      backgroundColor: getTheme().colorScheme.primaryContainer,
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
                          "configuration".i18n(),
                          style: TextStyle(
                            fontSize: 22,
                            color: getTheme().colorScheme.onPrimary,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 2, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: getTheme().colorScheme.onPrimary,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 20),
            _buildTrocarSenha,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildNotificacao,
            const SizedBox(height: 20),
            _buildLine,
            const SizedBox(height: 20),
            _buildTema,
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
            footer(token: token, email: email),
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
