import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'user.dart';
import 'package:pdm/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localization/localization.dart';

const kGoogleApiKey = "AIzaSyDjVyvOsvS2qsb2_ASvIFZRhAR-tjQmc3I";

class dadosPessoais extends StatefulWidget {
  const dadosPessoais({Key? key}) : super(key: key);

  @override
  State<dadosPessoais> createState() => _dadosPessoaisState();
}

class _dadosPessoaisState extends State<dadosPessoais> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController telefoneController = new TextEditingController();
  TextEditingController cidadeController = new TextEditingController();
  TextEditingController estadoController = new TextEditingController();

  String email = "";
  String nome = "";
  String numero = "";
  String cidade = "";
  String estado = "";

  @override
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
            onPressed: (() => print('config')),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: getTheme().colorScheme.primaryContainer,
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text('data'.i18n()),
          centerTitle: true,
          backgroundColor: Color(0xff388E3C),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 80),
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: getTheme().colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: nomeController,
                            decoration: InputDecoration(
                              labelText: "name".i18n(),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
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
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: emailController,
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
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: telefoneController,
                            decoration: InputDecoration(
                              labelText: "phone".i18n(),
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
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: cidadeController,
                            decoration: InputDecoration(
                              labelText: "city".i18n(),
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
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: estadoController,
                            decoration: InputDecoration(
                              labelText: "state".i18n(),
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
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () => http.post(
                              Uri.parse(
                                  'https://back-end-pdm.herokuapp.com/api/user/personaldata'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                "name": nome,
                                "password": email,
                                "phone": numero,
                                "city": cidade,
                                "state": estado,
                              }),
                            ),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: _buildFooter(),
      ),
    );
  }
}
