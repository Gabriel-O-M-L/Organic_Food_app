import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemList.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

import '../../../../auth/presentation/view/page/login.dart';
import '../../../../product/presentation/page/pesquisarLoja.dart';
import '../../../../product/presentation/page/pesquisarProduto.dart';
import '../../../../product/presentation/widget/footer.dart';
import '../../../../userSpace/presentation/page/personalData.dart';

class SearchScreen extends StatefulWidget {
  final String? token;
  final String? email;

  const SearchScreen({Key? key, this.token, this.email}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState(token, email);
}

class _SearchScreenState extends State<SearchScreen> {
  final String? token;
  final String? email;

  List<Produtos> listaProdutos = [
    Produtos(
      P_name: "toddy maçã",
      P_value: 5.94,
      P_type: "fruta",
      P_ratings: 0.0,
      P_seller: 1,
      P_seller_name: "toddy",
      P_id: 2,
    ),
    Produtos(
      P_name: "toddy maçã",
      P_value: 5.94,
      P_type: "fruta",
      P_ratings: 0.0,
      P_seller: 1,
      P_seller_name: "toddy",
      P_id: 2,
    ),
    Produtos(
      P_name: "toddy maçã",
      P_value: 5.94,
      P_type: "fruta",
      P_ratings: 0.0,
      P_seller: 1,
      P_seller_name: "toddy",
      P_id: 2,
    ),
    Produtos(
      P_name: "toddy maçã",
      P_value: 5.94,
      P_type: "fruta",
      P_ratings: 0.0,
      P_seller: 1,
      P_seller_name: "toddy",
      P_id: 2,
    ),
    Produtos(
      P_name: "toddy maçã",
      P_value: 5.94,
      P_type: "fruta",
      P_ratings: 0.0,
      P_seller: 1,
      P_seller_name: "toddy",
      P_id: 2,
    ),
  ];
  TextEditingController searchController = new TextEditingController();

  String search = "";
  String password = "";

  _SearchScreenState(this.token, this.email);
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
          labelText: "Pesquisar".i18n(),
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
              height: MediaQuery.of(context).size.height * 0.08,
              alignment: Alignment.topCenter,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pesquisa".i18n(),
                        style: TextStyle(
                            fontSize: 28,
                            color: getTheme().colorScheme.onPrimary)),
                  ]),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getTheme().colorScheme.secondary,
                        ),
                        child: TextButton(
                          child: Text(
                            'Pesquisar_Produto'.i18n(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: getTheme().colorScheme.onPrimary,
                                fontSize: 20),
                          ),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchProduct(
                                        token: token, email: email)),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getTheme().colorScheme.secondary,
                        ),
                        child: TextButton(
                          child: Text(
                            'Pesquisar_Loja'.i18n(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: getTheme().colorScheme.onPrimary,
                                fontSize: 20),
                          ),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchSeller(
                                        token: token, email: email)),
                              )),
                          // style: TextButton.styleFrom(
                          //     backgroundColor: getTheme().colorScheme.secondary),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // for (Produtos produtos in listaProdutos)
                      //   ProdutoItemList(
                      //     produto: produtos,
                      //   ),
                    ],
                  ),
                ),
              ],
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
