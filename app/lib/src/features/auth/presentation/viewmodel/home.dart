import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';

class Home_Page extends StatelessWidget {
  Home_Page({Key? key}) : super(key: key);

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
          Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.all(30),
            child: SvgPicture.asset(
              'lib/assets/images/leaf.svg',
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Horti em Casa",
            style: TextStyle(
              fontSize: 28,
              color: Color(0xff212121),
            ),
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
          SizedBox(
            width: 300,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: "password".i18n(),
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              onPressed: logar,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffFF5252),
                fixedSize: const Size(90, 40),
                primary: Colors.black,
              ),
              child: Text(
                "acess".i18n(),
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 120),
            TextButton(
              onPressed: cadastrar,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffFF5252),
                fixedSize: const Size(90, 40),
                primary: Colors.black,
              ),
              child: Text(
                "register".i18n(),
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 16,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 50),
          TextButton(
            onPressed: perdiSenha,
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text(
              "forgot_password".i18n(),
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 16,
              ),
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [],
          //     ),
          //   ),
          // ),
          // Container(
          //   color: const Color(0xff388E3C),
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.10,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         icon: SvgPicture.asset(
          //           'lib/assets/images/casa.svg',
          //         ),
          //         iconSize: 50,
          //         onPressed: logar,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
