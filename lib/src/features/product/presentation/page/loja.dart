import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/theme_manager.dart';

import '../../../search/presentation/view/page/search.dart';
import '../../../userSpace/presentation/page/config.dart';
import '../../../userSpace/presentation/page/user.dart';
import '../widget/produtosItemList.dart';

class LojaScreen extends StatefulWidget {
  final String? token;
  final String? email;
  const LojaScreen({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<LojaScreen> createState() => _LojaScreenState(token, email);
}

class _LojaScreenState extends State<LojaScreen> {
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

  _LojaScreenState(this.token, this.email);
  Widget _buildLine() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 3,
        color: getTheme().colorScheme.onPrimaryContainer);
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

  Widget _buildFooter() {
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
                        ConfigScreen(token: token, email: email),
                  ),
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
                          UserScreen(token: token, email: email)),
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
      body: Column(
        children: [
          Container(
            color: getTheme().colorScheme.primary,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset('lib/assets/images/legumes.svg'),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: Text(
                          "Produto",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: Text(
                          "Preço Médio",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: Text(
                          "Histório de Preço",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => {}),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(height: 30),
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            child: ListView(
              shrinkWrap: true,
              children: [
                for (Produtos produtos in listaProdutos)
                  ProdutoItemList(
                    produto: produtos,
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
    );
  }
}
