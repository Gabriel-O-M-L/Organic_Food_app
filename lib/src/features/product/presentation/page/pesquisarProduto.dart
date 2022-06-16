import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/page/listaProdutos.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../../../../../theme_manager.dart';
import '../widget/footer.dart';
import '../widget/produtosItemList.dart';
import '../model/lojamodel.dart';

class SearchProduct extends StatefulWidget {
  final String? token;
  final String? email;
  final Produtos? produtoF;
  const SearchProduct({Key? key, this.token, this.email, this.produtoF})
      : super(key: key);

  @override
  State<SearchProduct> createState() =>
      _SearchProductState(token, email, produtoF);
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController produtoController = new TextEditingController();

  final String? token;
  final String? email;
  final Produtos? produtoF;
  String? produtoId;
  int? produtoIdInt;
  String? product;
  Produtos? produto;
  List<String> idProduto = [];
  List<Produtos> listaProdutos = [];
  Produtos? produtoNomeId;

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
          title: Text("Alerta!", style: TextStyle(fontSize: 28)),
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

  Future<http.Response> showProductId(String product) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/search/');

    Map data = {
      "P_name": product,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      produtoId = response.body;
      produtoId = produtoId!.replaceAll('{"array":[', '');
      produtoId = produtoId!.replaceAll(']}', '');
      print(produtoId);
      idProduto = produtoId!.split(",");
      print(idProduto);
      print(idProduto.length);
      if (idProduto.length > 1) {
        print("id ok!");
        for (String id in idProduto) {
          int idInt = int.parse(id);
          print(idInt < 0);

          showProduct(idInt);
        }
      } else {
        alertDialog("Produto_nao_encontrado");
      }
    } else
      print("Error!");

    return response;
  }

  Future<Produtos?> showProduct(int product) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/show/');

    Map data = {
      "P_id": product,
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
        listaProdutos.add(Produtos.fromJson(jsonDecode(response.body)));
        print(listaProdutos.length);
        produtoNomeId = Produtos.fromJson(jsonDecode(response.body));
      });
      return Produtos.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _SearchProductState(this.token, this.email, this.produtoF);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: getTheme().colorScheme.primary,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 15),
                    child: TextFormField(
                      onChanged: (text) {
                        listaProdutos.clear();
                        idProduto.clear();
                      },
                      controller: produtoController,
                      decoration: InputDecoration(
                        labelText: "product".i18n(),
                        labelStyle: TextStyle(
                          fontSize: 22,
                          color: getTheme().colorScheme.tertiary,
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
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 2,
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
                        onPressed: () {
                          product = produtoController.text;
                          setState(() {
                            showProductId(product!);
                          });
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (listaProdutos != null)
                    for (var x = 0; x < listaProdutos.length; x++)
                      ProdutoItemList(
                        produto: listaProdutos[x],
                        token: token!,
                        alertDialog: alertDialog,
                      ),
                  // listaNova(
                  //   produto: listaProdutos[x],
                  //   token: '',
                  //   alertDialog: alertDialog,
                  // ),
                ],
              ),
            ),
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
      ),
    );
  }
}
