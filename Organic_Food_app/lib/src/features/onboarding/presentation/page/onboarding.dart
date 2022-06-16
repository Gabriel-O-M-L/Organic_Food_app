import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'contentOnboarding.dart';
import '../../../auth/presentation/view/page/login.dart';
import 'package:pdm/src/features/auth/auth_module.dart';
import 'package:localization/localization.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          contents[i].image,
                          height: 200,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: ListView(
                            children: [
                              Text(contents[i].discription,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        ),
                      ]),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: FlatButton(
              child: Text(
                  currentIndex == contents.length - 1
                      ? 'go_forward'.i18n()
                      : 'next'.i18n(),
                  style: TextStyle(fontSize: 26)),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/auth/', (Route<dynamic> route) => false);
                }
                _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              color: Color(0xff388E3C),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff388E3C),
      ),
    );
  }
}
