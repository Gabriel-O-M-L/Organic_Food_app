import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/model/lojamodel.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemList.dart';
import 'package:pdm/src/features/product/presentation/widget/produtosItemListCarrinho.dart';
import 'package:pdm/src/features/seller/presentation/page/areaProdutor.dart';

import '../../../../../theme_manager.dart';

class ItensVendedor extends StatefulWidget {
  final String? token;
  final String? email;
  const ItensVendedor({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<ItensVendedor> createState() => _ItensVendedorState(token, email);
}

class _ItensVendedorState extends State<ItensVendedor> {
  TextEditingController produtoController = new TextEditingController();

  final String? token;
  final String? email;
  String? produtoId;
  int? produtoIdInt;
  String? product;
  Produtos? produto;
  List<String> idProdutos = [];
  List<Produtos> listaProdutos = [];
  Produtos? novoProduto;
  Loja? loja;
  String? produtoNome;
  Produtos? deletedProduto;
  int? deletedProdutoPos;

  void initState() {
    super.initState();

    setState(() {
      listaProdutos.clear();
      showIdSeller();
    });
  }

  void onDelete(Produtos produto) {
    deletedProduto = produto;
    deletedProdutoPos = listaProdutos.indexOf(produto);
    setState(() {
      listaProdutos.remove(produto);
      deleteProduto(produto.P_id);
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
          label: "Desfazer",
          textColor: getTheme().colorScheme.onPrimary,
          onPressed: () {
            setState(() {
              listaProdutos.insert(deletedProdutoPos!, deletedProduto!);
              createProduto();
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<http.Response> deleteProduto(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/delete/');

    Map data = {
      "jwt": token,
      "P_id": id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print("produto apagado ok!");
    } else
      print("Error apagar!");

    return response;
  }

  Future<http.Response> createProduto() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/create/');

    Map data = {
      "jwt": token,
      "P_name": deletedProduto!.P_name,
      "P_type": deletedProduto!.P_type,
      "P_value": deletedProduto!.P_value,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 201) {
      print("produto criado ok!");
    } else
      print("Error criar!");

    return response;
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
                          areaProdutor(token: token, email: email)),
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

  Future<http.Response> showIdSeller() async {
    var url =
        Uri.parse('https://back-end-pdm.herokuapp.com/product/myproduct/');

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

      if (idProdutos.length > 2) {
        for (String id in idProdutos) {
          int idInt = int.parse(id);
          showProduct(idInt);

          print(idInt);
        }
      } else {
        alertDialog("Você_nao_possui_produtos!".i18n());
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

  _ItensVendedorState(this.token, this.email);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   FocusManager.instance.primaryFocus?.unfocus();
      //   listaProdutos.clear();
      //   showIdSeller();
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: getTheme().colorScheme.primary,
          title: Text(
            "Seus_Itens".i18n(),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (listaProdutos.isEmpty)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 300.0),
            //     child: Container(
            //       height: 150,
            //       width: 300,
            //       child: Text("Clique na tela para carregar!",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontSize: 35,
            //               fontWeight: FontWeight.bold,
            //               color: getTheme().colorScheme.onPrimaryContainer)),
            //     ),
            //   ),
            SizedBox(height: 30),
            if (listaProdutos.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (listaProdutos != null)
                      for (Produtos p in listaProdutos)
                        ProdutoItemListCarrinho(
                          produto: p,
                          onDelete: onDelete,
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
