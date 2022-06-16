import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/userSpace/presentation/page/config.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

class MeusProdutosScreen extends StatefulWidget {
  final String? token;
  final String? email;
  const MeusProdutosScreen({Key? key, this.token, this.email})
      : super(key: key);

  @override
  State<MeusProdutosScreen> createState() =>
      _MeusProdutosScreenState(token, email);
}

class _MeusProdutosScreenState extends State<MeusProdutosScreen> {
  final String? token;
  final String? email;

  _MeusProdutosScreenState(this.token, this.email);
  Widget _buildFooter() {
    return Container(
      color: const Color(0xff388E3C),
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

  Widget _buildContainer(String text) {
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
                  child: _buildContainer("Escolha_o_produto".i18n()),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _buildContainer("Alterar_Preço".i18n()),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _buildContainer("Remover_Produto".i18n()),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
