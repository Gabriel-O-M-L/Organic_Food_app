import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'dart:convert';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/product/presentation/page/recomendacao.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemListCarrinhoRate.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/userSpace/presentation/page/config.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

import '../widget/produtosItemListCarrinho.dart';

class CarrinhoScreen extends StatefulWidget {
  final String? token;
  final String? email;
  const CarrinhoScreen({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState(token, email);
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final String? token;
  final String? email;
  Produtos? deletedProduto;
  int? deletedProdutoPos;
  String? produtoId;
  List<String> idProduto = [];
  List<Produtos> listaProdutos = [];
  List<String> listaRecomed = [];

  _CarrinhoScreenState(this.token, this.email);

  void initState() {
    super.initState();

    setState(() {
      showProductByName();
      listaProdutos.clear();
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

  Future<http.Response> getProdutoRecomendado(int id) async {
    var url = Uri.parse(
        'https://back-end-pdm.herokuapp.com/recommendation/recommend/');

    Map data = {
      "jwt": token,
      "P_id": id,
      "type": "recommend",
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    String recomendacao;
    List<String> list = [];
    recomendacao = response.body;
    print(recomendacao);
    recomendacao = recomendacao.replaceAll('["[', '');
    recomendacao = recomendacao.replaceAll(']"]', '');
    listaRecomed = recomendacao.split(',');
    print("lista: " + list.toString());
    print(recomendacao);

    if (response.statusCode == 200) {
      print("Lista Recomendação Ok!");
    } else {
      print("Lista Recomendação Error!");
    }

    return response;
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
        for (String id in idProduto) {
          int idInt = int.parse(id);
          // showProductById(idInt);
          getProdutoRecomendado(idInt);
        }
      } else {
        alertDialog("Número_minimo_de_itens_2".i18n());
      }
    } else {
      alertDialog("Carrinho_Vazio");
      print("Produto por ID Error!");
    }

    return response;
  }

  Future<void> finalizarCompra() async {
    // removeCarrinho();
    // mandarMsg();
    // listaProdutos.clear();
    print(listaRecomed);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecomendacaoScreen(
                token: token,
                email: email,
                listaRecomed: listaRecomed,
              )),
    );
  }

  Future<http.Response> mandarMsg() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/finish/');

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
      print("Msg Enviada");
      ;
    } else
      print("Msg Error!");

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

  Future<http.Response> removeCarrinho() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/delete/');

    Map data = {
      "jwt": token,
    };

    var body = json.encode(data);

    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Carrinho Removido ok!");
    } else
      print("Carrinho Removido Error!");

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
            "Meu_Carrinho".i18n(),
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
                          ProdutoItemListCarrinhoRate(
                            produto: produtos,
                            onDelete: onDelete,
                            token: token!,
                            email: email,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getTheme().colorScheme.secondary,
                      ),
                      child: TextButton(
                          child: Text(
                            'Finalizar_Compra'.i18n(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: getTheme().colorScheme.onPrimary,
                                fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              finalizarCompra();
                            });
                          }),
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

  void onDelete(Produtos produto) {
    deletedProduto = produto;
    deletedProdutoPos = listaProdutos.indexOf(produto);
    setState(() {
      listaProdutos.remove(produto);
      removeProduct(produto.P_id);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Produto ${produto.P_name} foi removida com sucesso!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: getTheme().colorScheme.secondary,
        action: SnackBarAction(
          label: "Desfazer".i18n(),
          textColor: getTheme().colorScheme.onPrimary,
          onPressed: () {
            setState(() {
              listaProdutos.insert(deletedProdutoPos!, deletedProduto!);
              addCarrinho(produto.P_id);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
