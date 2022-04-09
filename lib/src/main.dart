import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/app_module.dart';
import 'package:pdm/src/app_widget.dart';
import 'package:pdm/src/features/onboarding/presentation/page/onboarding.dart';

import 'features/auth/presentation/view/page/login.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
