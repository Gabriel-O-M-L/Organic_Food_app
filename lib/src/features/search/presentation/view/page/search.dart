import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();

  String search = "";
  String password = "";
  Widget get _buildSearchTF {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: searchController,
        style: TextStyle(color: getTheme().colorScheme.onTertiary),
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: getTheme().colorScheme.onTertiary,
            size: 50,
          ),
          labelText: "Pesquisar",
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
            color: getTheme().colorScheme.onPrimary,
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
            color: getTheme().colorScheme.onPrimary,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/lupa.svg',
            ),
            iconSize: 50,
            onPressed: (() => print('config')),
            color: getTheme().colorScheme.onPrimary,
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
              height: MediaQuery.of(context).size.height * 0.08,
              alignment: Alignment.topCenter,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSearchTF,
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
                    color: getTheme().colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 1.2, 0),
                child: Icon(
                  Icons.update,
                  color: getTheme().colorScheme.onPrimaryContainer,
                  size: 30.0,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, MediaQuery.of(context).size.width / 1.2, 0),
                child: Icon(
                  Icons.update,
                  color: getTheme().colorScheme.onPrimaryContainer,
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
                    color: getTheme().colorScheme.onPrimaryContainer,
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
            _buildFooter,
          ],
        ),
      ]),
    );
    throw UnimplementedError();
  }
}
