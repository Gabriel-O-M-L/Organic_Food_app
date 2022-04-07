import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';

class RecuperarSenha extends StatelessWidget {
  RecuperarSenha({Key? key}) : super(key: key);

  final Widget svg = SvgPicture.asset('lib/assets/images/leaf.svg');

  void logar() {}
  void cadastrar() {}
  void perdiSenha() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color(0xff388E3C),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Text(
            "password_reset".i18n(),
            style: TextStyle(
              fontSize: 28,
              color: Color(0xff212121),
              fontFamily: "Asap",
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: 300,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: "name".i18n(),
                labelStyle: TextStyle(
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
          ),
          const SizedBox(height: 30),
          const SizedBox(
            width: 300,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
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
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: "new_password".i18n(),
                labelStyle: TextStyle(
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          TextButton(
            onPressed: logar,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffFF5252),
              fixedSize: const Size(120, 60),
              primary: Colors.black,
            ),
            child: Text(
              "recover".i18n(),
              style: TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 20,
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
          Container(
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
                  onPressed: logar,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/images/pessoa.svg',
                  ),
                  iconSize: 50,
                  onPressed: logar,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/images/lupa.svg',
                  ),
                  iconSize: 50,
                  onPressed: logar,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
