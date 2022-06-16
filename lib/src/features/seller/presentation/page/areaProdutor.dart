import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/seller/presentation/produtosVendedor.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/userSpace/model/userModel.dart';

import '../../../../../theme_manager.dart';
import 'adicionarProduto.dart';

class areaProdutor extends StatefulWidget {
  final String? token;
  final String? email;
  const areaProdutor({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<areaProdutor> createState() => _areaProdutorState(token, email);
}

class _areaProdutorState extends State<areaProdutor> {
  final String? token;
  final String? email;
  UserModel? user;
  int x = 8;

  Future<UserModel?> showUser() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/user/getuser/');

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
      print("sucesso!");

      setState(() {
        user = UserModel.fromJson(jsonDecode(response.body));
      });
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _areaProdutorState(this.token, this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getTheme().colorScheme.primary,
        title: Text(
          "Area_do_Produtor".i18n(),
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / x,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: getTheme().colorScheme.secondary,
                ),
                child: TextButton(
                  child: Text(
                    'Adicionar_Produto'.i18n(),
                    style: TextStyle(
                        color: getTheme().colorScheme.onPrimary, fontSize: 28),
                  ),
                  onPressed: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdicionarProdutoScreen(
                                token: token, email: email)),
                      )),
                  // style: TextButton.styleFrom(
                  //     backgroundColor: getTheme().colorScheme.secondary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: getTheme().colorScheme.secondary,
                ),
                child: TextButton(
                  child: Text(
                    'Ver_Meus_Produto'.i18n(),
                    style: TextStyle(
                        color: getTheme().colorScheme.onPrimary, fontSize: 28),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItensVendedor(token: token, email: email)),
                    );
                  },
                  // style: TextButton.styleFrom(
                  //     backgroundColor: getTheme().colorScheme.secondary),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
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
