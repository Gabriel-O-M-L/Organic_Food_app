import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pdm/theme_manager.dart';

class listaNova extends StatelessWidget {
  listaNova({
    Key? key,
    required this.produto,
    required this.token,
    required this.alertDialog,
  }) : super(key: key);

  final Produtos produto;
  final String token;
  final Function(String) alertDialog;
  bool add = false;

  Future<http.Response> criarCarrinho() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/create/');

    Map data = {
      "jwt": token,
      "P_id": produto.P_id,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 201) {
      print(response.body);
      alertDialog("Produto_Adicionado".i18n());
      print("Carrinho Criado!");
      add = true;
    } else if (response.statusCode == 400) {
      print("Carrinho Existente!");
      addCarrinho();
    } else
      print("Carrinho Error!");

    return response;
  }

  Future<http.Response> addCarrinho() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/add/');

    Map data = {
      "jwt": token,
      "P_id": produto.P_id,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Carrinho add");
      alertDialog("Produto_Adicionado".i18n());
      add = true;
    } else
      print("Carrinho Error!");

    return response;
  }

  Future<http.Response> deleteItemCarrinho() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/cart/remove/');

    Map data = {
      "jwt": token,
      "P_id": produto.P_id,
    };

    var body = json.encode(data);

    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      print("Item removido");
      alertDialog("Produto_Removido".i18n());
      add = false;
    } else
      print("Carrinho Error!");

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (add) {
          deleteItemCarrinho();
        } else {
          criarCarrinho();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: getTheme().colorScheme.tertiary,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(Icons.shopping_basket_outlined, size: 70.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome:".i18n() + produto.P_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Preço:".i18n() + produto.P_value.toString() + "R\$",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Tipo:".i18n() + produto.P_type,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Rating:".i18n() + produto.P_ratings.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Vendedor:".i18n() + produto.P_seller_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
