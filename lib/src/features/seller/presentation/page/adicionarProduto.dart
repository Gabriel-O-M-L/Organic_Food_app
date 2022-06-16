import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/seller/presentation/page/areaProdutor.dart';

import '../../../../../theme_manager.dart';
import '../../../search/presentation/view/page/search.dart';
import '../../../userSpace/presentation/page/config.dart';
import '../../../userSpace/presentation/page/user.dart';

class AdicionarProdutoScreen extends StatefulWidget {
  final String? token;
  final String? email;
  const AdicionarProdutoScreen({Key? key, this.token, this.email})
      : super(key: key);

  @override
  State<AdicionarProdutoScreen> createState() =>
      _AdicionarProdutoScreenState(token, email);
}

class _AdicionarProdutoScreenState extends State<AdicionarProdutoScreen> {
  final String? token;
  final String? email;
  String? nome;
  String? tipo;
  double? valor;
  String? preco;

  _AdicionarProdutoScreenState(this.token, this.email);

  Future<http.Response> createProduct() async {
    // print("token: " + token!);

    var url = Uri.parse('https://back-end-pdm.herokuapp.com/product/create/');

    Map data = {
      "jwt": token,
      "P_name": nome,
      "P_type": tipo,
      "P_value": valor,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 201) {
      print("Produto Criado");

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => areaProdutor(token: token, email: email)),
      );
    } else
      print("Error!");
    return response;
  }

  TextEditingController tipoController = new TextEditingController();
  TextEditingController precoController = new TextEditingController();
  TextEditingController nomeController = new TextEditingController();

  List<String> produtos = ["Fruta", "Hortaliça", "Legume", "Verdura"];
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

  Widget _buildContainer(String text, TextEditingController control) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getTheme().colorScheme.primary,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Align(
              child: Text(
                text,
                style: TextStyle(
                  color: getTheme().colorScheme.onPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
            child: TextFormField(
              controller: control,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: getTheme().colorScheme.primary,
            title: Text(
              "Adicionar_Produto".i18n(),
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getTheme().colorScheme.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: _buildContainer(
                              "Tipo_de_Produto".i18n(), tipoController),
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.height,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child:
                      _buildContainer("Preço_por_KG".i18n(), precoController),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child:
                      _buildContainer("Nome_do_Produto".i18n(), nomeController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getTheme().colorScheme.secondary,
                    ),
                    child: TextButton(
                      child: Text(
                        'Adicionar_Produto'.i18n(),
                        style: TextStyle(
                            color: getTheme().colorScheme.onPrimary,
                            fontSize: 28),
                      ),
                      onPressed: () {
                        nome = nomeController.text;
                        tipo = tipoController.text;
                        String preco =
                            precoController.text.replaceAll(",", ".");
                        valor = double.parse(preco);
                        print(preco);
                        createProduct();
                      },
                      // style: TextButton.styleFrom(
                      //     backgroundColor: getTheme().colorScheme.secondary),
                    ),
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
        ),
      ),
    );
  }
}
