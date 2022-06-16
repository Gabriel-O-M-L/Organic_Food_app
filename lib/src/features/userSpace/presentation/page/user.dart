import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/product/presentation/page/carrinho.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/userSpace/presentation/page/areaChat.dart';
import 'package:pdm/theme_manager.dart';
import '../../../seller/presentation/page/adicionarProduto.dart';
import '../../../seller/presentation/page/areaProdutor.dart';
import '../../model/userModel.dart';
import 'personalData.dart';

import 'config.dart';

class UserScreen extends StatefulWidget {
  final String? token;
  final String? email;

  const UserScreen({Key? key, this.token, this.email}) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState(token, email);
}

class _UserScreenState extends State<UserScreen> {
  final String? token;
  final String? email;
  UserModel? user;

  _UserScreenState(this.token, this.email);
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CarrinhoScreen(token: token, email: email)),
        );
      },
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "cart".i18n(),
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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserScreen(token: token, email: email)),
                );
              },
            ),
          ],
          title: Text("Alerta".i18n(), style: TextStyle(fontSize: 28)),
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

  Future<UserModel?> showUser() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/user/getuser/');

    Map data = {
      "jwt": token,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print("sucesso!");

      setState(() {
        user = UserModel.fromJson(jsonDecode(response.body));
        cadastrarSeller(user!.name);
      });
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> cadastrarSeller(String nome) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/seller/create/');

    Map data = {
      "jwt": token,
      "S_name": nome,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 201) {
      print("Criado/Existente");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => areaProdutor(token: token, email: email)),
      );
    } else {
      print("Error!");
      alertDialog("Falta_dados".i18n());
    }

    return response;
  }

  Widget get _buildProdutor {
    return TextButton(
      onPressed: (() {
        showUser();
      }),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'want_be_seller'.i18n(),
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
            MaterialPageRoute(
                builder: (context) =>
                    dadosPessoais(token: token, email: email)),
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
      onPressed: (() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => areaChat(token: token, email: email)),
          )),
      style: TextButton.styleFrom(
        primary: getTheme().colorScheme.onPrimaryContainer,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "Chat".i18n(),
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
            MaterialPageRoute(
                builder: (context) => ConfigScreen(token: token, email: email)),
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
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserScreen(token: token, email: email)),
                )),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/pessoa.svg',
            ),
            iconSize: 50,
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          dadosPessoais(token: token, email: email)),
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
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(token: token, email: email)),
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
                          Text(
                            'Email:'.i18n() + email!,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(children: [
                Column(children: [
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
                  _buildProdutor,
                  const SizedBox(height: 20),
                  _buildLine,
                  const SizedBox(height: 20),
                ])
              ]),
            ),
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
