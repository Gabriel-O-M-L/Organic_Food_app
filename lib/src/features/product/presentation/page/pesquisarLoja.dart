import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemListCarrinho.dart';

import '../../../../../theme_manager.dart';
import '../widget/footer.dart';
import '../widget/produtosItemList.dart';
import '../model/lojamodel.dart';

class SearchSeller extends StatefulWidget {
  final String? token;
  final String? email;
  const SearchSeller({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<SearchSeller> createState() => _SearchSellertState(token, email);
}

class _SearchSellertState extends State<SearchSeller> {
  TextEditingController produtoController = new TextEditingController();

  final String? token;
  final String? email;
  String? produtoId;
  int? produtoIdInt;
  String? product;
  // Produtos? produto = new Produtos(
  //     P_id: 1,
  //     P_name: 'toddy',
  //     P_ratings: 1,
  //     P_seller_name: 'toddy',
  //     P_seller: 1,
  //     P_type: 'toddy',
  //     P_value: 1);
  List<String> idProdutos = [];
  List<Produtos> listaProdutos = [];
  Produtos? novoProduto;
  Loja? loja;
  String? produtoNome;

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

  Future<Loja?> showProductId(String product) async {
    var url =
        Uri.parse('https://back-end-pdm.herokuapp.com/seller/searchname/');

    Map data = {
      "S_name": product,
    };
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      loja = Loja.fromJson(jsonDecode(response.body));
      print(loja!.S_id);
      print("id ok!");
      print(loja);
      showIdSeller(loja!.S_id);
      return Loja.fromJson(jsonDecode(response.body));
    } else {
      alertDialog("Vendedor_nao_encontrado".i18n());
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> showIdSeller(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/seller/');

    Map data = {
      "P_seller": id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      produtoId = response.body;
      produtoId = produtoId!.replaceAll('{"array":', '');
      produtoId = produtoId!.replaceAll('}', '');
      produtoId = produtoId!.replaceAll('[', '');
      produtoId = produtoId!.replaceAll(']', '');
      produtoId = produtoId!.replaceAll('"', '');
      print(produtoId);
      idProdutos = produtoId!.split(",");
      print(idProdutos);
      print("produtos ok!");

      for (String id in idProdutos) {
        int idInt = int.parse(id);
        showProduct(idInt);

        print(idInt);
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
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        listaProdutos.add(Produtos.fromJson(jsonDecode(response.body)));
      });

      print("sucesso!");
      return Produtos.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  _SearchSellertState(this.token, this.email);
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
                        setState(() {
                          listaProdutos.clear();
                          idProdutos.clear();
                        });
                      },
                      controller: produtoController,
                      decoration: InputDecoration(
                        labelText: "Vendedor".i18n(),
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
                          'Pesquisar_Vendedor'.i18n(),
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
                          listaProdutos.clear();
                          idProdutos.clear();
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: ListView(
                shrinkWrap: false,
                children: [
                  if (listaProdutos != null)
                    for (Produtos p in listaProdutos)
                      ProdutoItemList(
                        produto: p,
                        token: token!,
                        alertDialog: alertDialog,
                      ),
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
