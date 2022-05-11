import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toddy/ResetPassoword.dart';
import 'package:toddy/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:toddy/user.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();

  String search = "";
  String password = "";
  Widget _buildSearchTF() {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: searchController,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
            size: 50,
          ),
          labelText: "Pesquisar",
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
                    _buildSearchTF(),
                  ]),
            ),
            const SizedBox(height: 80),
            Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 2, 0),
                child: Text(
                  "Busca Recentes",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff212121),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 1.2, 0),
                child: Icon(
                  Icons.update,
                  color: Color(0xff757575),
                  size: 30.0,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 1.2, 0),
                child: Icon(
                  Icons.update,
                  color: Color(0xff757575),
                  size: 30.0,
                ),
              ),
              const SizedBox(height: 60),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 2, 0),
                child: Text(
                  "Você Procura Por",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff212121),
                  ),
                ),
              ),
            ]),
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
