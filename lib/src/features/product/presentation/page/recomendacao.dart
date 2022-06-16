import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'dart:convert';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemList.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemListCarrinhoRate.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/userSpace/presentation/page/config.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

import '../widget/produtosItemListCarrinho.dart';

class RecomendacaoScreen extends StatefulWidget {
  final String? token;
  final String? email;
  final List<String> listaRecomed;
  const RecomendacaoScreen(
      {Key? key, this.token, this.email, required this.listaRecomed})
      : super(key: key);

  @override
  State<RecomendacaoScreen> createState() =>
      _RecomendacaoScreenState(token, email, listaRecomed);
}

class _RecomendacaoScreenState extends State<RecomendacaoScreen> {
  final String? token;
  final String? email;
  String? produtoId;
  List<String> idProduto = [];
  List<Produtos> listaProdutos = [];
  final List<String> listaRecomed;

  _RecomendacaoScreenState(this.token, this.email, this.listaRecomed);

  void initState() {
    super.initState();

    setState(() {
      print(listaRecomed);
      for (String x in listaRecomed) {
        int id = int.parse(x);
        showProductById(id);
      }
    });
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

  Future<http.Response> showProductByName() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/show/');

    Map data = {
      "jwt": token,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      produtoId = response.body;
      produtoId = produtoId!.replaceAll('[', '');
      produtoId = produtoId!.replaceAll(']', '');
      produtoId = produtoId!.replaceAll('"', '');
      print("id produto: " + produtoId!);
      idProduto = produtoId!.split(",");

      print(idProduto);
      print("lista vazia? " + idProduto.isEmpty.toString());
      print("Produto por ID ok!");

      if (idProduto.length > 1) {
        for (String id in idProduto) {
          int idInt = int.parse(id);
          showProductById(idInt);
          // getProdutoRecomendado(idInt);
        }
      } else {
        alertDialog("Número_minimo_de_itens_2");
      }
    } else {
      alertDialog("Carrinho_Vazio");
      print("Produto por ID Error!");
    }

    return response;
  }

  Future<http.Response> addCarrinho(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/add/');

    Map data = {
      "jwt": token,
      "P_id": id,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Carrinho add");
      ;
    } else
      print("Carrinho Error!");

    return response;
  }

  Future<http.Response> removeProduct(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/remove/');

    Map data = {
      "jwt": token,
      "P_id": id,
    };

    var body = json.encode(data);

    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Produto Removido ok!");
    } else
      print("Produto Removido Error!");

    return response;
  }

  Future<Produtos?> showProductById(int product) async {
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
      print("Mostrar Produto sucesso!");

      setState(() {
        listaProdutos.add(Produtos.fromJson(jsonDecode(response.body)));
      });
      return Produtos.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Mostrar Produto Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
        // listaProdutos.clear();
        // showProductByName();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: getTheme().colorScheme.primary,
          title: Text(
            "Recomendações".i18n(),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // if (listaProdutos.isEmpty)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 300.0),
            //     child: Container(
            //       height: 150,
            //       width: 300,
            //       child: Text("Clique na tela para carregar ou carrinho vazio!",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontSize: 35,
            //               fontWeight: FontWeight.bold,
            //               color: getTheme().colorScheme.onPrimaryContainer)),
            //     ),
            //   ),
            SizedBox(height: 30),
            if (listaProdutos.isNotEmpty)
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (Produtos produtos in listaProdutos)
                          ProdutoItemList(
                            token: token!,
                            alertDialog: alertDialog,
                            produto: produtos,
                          ),
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
            footer(token: token, email: email),
          ],
        ),
      ),
    );
  }
}
