import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toddy/user.dart';
import 'theme_manager.dart';

const kGoogleApiKey = "AIzaSyDjVyvOsvS2qsb2_ASvIFZRhAR-tjQmc3I";

class dadosPessoais extends StatefulWidget {
  const dadosPessoais({Key? key}) : super(key: key);

  @override
  State<dadosPessoais> createState() => _dadosPessoaisState();
}

class _dadosPessoaisState extends State<dadosPessoais> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController telefoneController = new TextEditingController();
  TextEditingController cidadeController = new TextEditingController();
  TextEditingController estadoController = new TextEditingController();

  final itens = [
    'Brasília',
    'Guará',
    'Recanto',
    'Núcleo Bandeirante',
    'Cruzeiro'
  ];

  String email = "";
  String nome = "";
  int numero = 0;
  String cidade = "";
  String estado = "";

  @override
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
            onPressed: (() => print('config')),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/pessoa.svg',
            ),
            iconSize: 50,
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                )),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            icon: SvgPicture.asset(
              'lib/assets/images/lupa.svg',
            ),
            iconSize: 50,
            onPressed: (() => print('config')),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text("Dados Pessoais"),
          centerTitle: true,
          backgroundColor: Color(0xff388E3C),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 80),
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: getTheme().colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: nomeController,
                            decoration: InputDecoration(
                              labelText: "Nome",
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: Color(0xffBDBDBD),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffBDBDBD),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: Color(0xffBDBDBD),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffBDBDBD),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: telefoneController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: Color(0xffBDBDBD),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffBDBDBD),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: cidadeController,
                            decoration: InputDecoration(
                              labelText: "Cidade",
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: Color(0xffBDBDBD),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffBDBDBD),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: estadoController,
                            decoration: InputDecoration(
                              labelText: "Estado",
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: Color(0xffBDBDBD),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffBDBDBD),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () => print("print"),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffFF5252),
                              fixedSize: const Size(90, 40),
                              primary: Colors.black,
                            ),
                            child: const Text(
                              "Cadastrar",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: _buildFooter(),
      ),
    );
  }
}
