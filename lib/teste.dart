import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/src/features/auth/presentation/view/page/ResetPassoword.dart';
import 'package:pdm/src/features/auth/presentation/view/page/login.dart';
import 'package:pdm/src/features/product/presentation/page/carrinho.dart';
import 'package:pdm/src/features/product/presentation/page/pesquisarLoja.dart';
import 'package:pdm/src/features/product/presentation/page/pesquisarProduto.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/seller/presentation/page/adicionarProduto.dart';
import 'package:pdm/src/features/seller/presentation/page/areaProdutor.dart';
import 'package:pdm/src/features/seller/presentation/produtosVendedor.dart';
import 'package:pdm/src/features/userSpace/presentation/chatList.dart';
import 'package:pdm/src/features/userSpace/presentation/page/chatBot.dart';
import 'package:pdm/src/features/userSpace/presentation/page/personalData.dart';
import 'package:pdm/src/features/userSpace/presentation/page/sendchat.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';

void main() async {
  runApp(MaterialApp(
    home: dadosPessoais(
      token:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMDEzLCJleHAiOjE2NTU5NTEwOTAxNjYuOTk3fQ.tJoJVtfpeGE6bCJZwkhHB8-LI3Kqy6ZJOLR3aLoFihs",
      email: "tico@tucky.com.br",
    ),
  ));
}
