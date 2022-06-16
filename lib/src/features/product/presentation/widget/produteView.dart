import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/page/carrinho.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdutoView extends StatefulWidget {
  final Produtos produto;
  final String? token;
  final String? email;
  const ProdutoView({Key? key, required this.produto, this.token, this.email})
      : super(key: key);

  @override
  State<ProdutoView> createState() => _ProdutoViewState(produto, token, email);
}

class _ProdutoViewState extends State<ProdutoView> {
  TextEditingController notaController = new TextEditingController();
  String? notaStr;
  double? nota;
  final String? token;
  final String? email;
  final Produtos produto;

  Future<http.Response> sendNota(double nota) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/rate/');

    Map data = {
      "jwt": token,
      "P_id": produto.P_id,
      "P_rating": nota,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print("Nota enviada!");
    } else
      print("Nota enviada Error!");

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
              },
            )
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

  _ProdutoViewState(this.produto, this.token, this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            // height: MediaQuery.of(context).size.height / .50,
            // width: MediaQuery.of(context).size.width / .5,
            decoration: BoxDecoration(
              color: getTheme().colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart,
                    color: getTheme().colorScheme.onPrimary, size: 150),
                SizedBox(height: 100),
                Text(
                  "Nome:".i18n() + produto.P_name,
                  style: TextStyle(
                      color: getTheme().colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Preço:".i18n() + produto.P_value.toString(),
                  style: TextStyle(
                      color: getTheme().colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Tipo:".i18n() + produto.P_type,
                  style: TextStyle(
                      color: getTheme().colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Rating:".i18n() + produto.P_ratings.toStringAsFixed(2),
                  style: TextStyle(
                      color: getTheme().colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Vendedor:".i18n() + produto.P_seller_name,
                  style: TextStyle(
                      color: getTheme().colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: notaController,
                    decoration: InputDecoration(
                      labelText: "nota_do_protudo".i18n(),
                      labelStyle: TextStyle(
                        fontSize: 22,
                        color: getTheme().colorScheme.onPrimaryContainer,
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
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: getTheme().colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      child: Text(
                        'Dar nota!'.i18n(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: getTheme().colorScheme.onPrimary,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        notaStr = notaController.text;
                        notaStr = notaStr!.replaceAll(",", ".");

                        nota = double.parse(notaStr!);
                        if (nota! > 10) {
                          alertDialog("Nota_deve_ser_de_0_a_10!".i18n());
                          notaController.clear();
                        } else {
                          print(nota);
                          setState(() {
                            sendNota(nota!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarrinhoScreen(
                                      token: token, email: email)),
                            );
                          });
                        }
                      }),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: getTheme().colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      child: Text(
                        'Voltar'.i18n(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: getTheme().colorScheme.onPrimary,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        print(token);
                        print(email);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarrinhoScreen(token: token, email: email)),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
