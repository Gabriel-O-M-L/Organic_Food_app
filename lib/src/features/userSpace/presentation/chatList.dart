import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'dart:convert';
import 'package:pdm/src/features/product/presentation/model/produtos.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/search/presentation/view/page/search.dart';
import 'package:pdm/src/features/userSpace/model/chatUserModel.dart';
import 'package:pdm/src/features/userSpace/presentation/page/ChatItem.dart';
import 'package:pdm/src/features/userSpace/presentation/page/config.dart';
import 'package:pdm/src/features/userSpace/presentation/page/user.dart';
import 'package:pdm/theme_manager.dart';

class ChatListScreen extends StatefulWidget {
  final String? token;
  final String? email;
  const ChatListScreen({Key? key, this.token, this.email}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState(token, email);
}

class _ChatListScreenState extends State<ChatListScreen> {
  final String? token;
  final String? email;
  Produtos? deletedProduto;
  int? deletedProdutoPos;
  String? idJson;
  List<String> listaId = [];
  List<ChatUserModel> listaUser = [];

  void initState() {
    super.initState();

    setState(() {
      getListaChatId();
    });
  }

  _ChatListScreenState(this.token, this.email);

  Future<http.Response> getListaChatId() async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/chat/getlist/');

    Map data = {
      "jwt": token,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      idJson = response.body;
      idJson = idJson!.replaceAll('{"idlist":"[', '');
      idJson = idJson!.replaceAll(']"}', '');
      print(idJson);
      listaId = idJson!.split(",");
      print(listaId);
      print("Lista de ID ok!");
      for (String id in listaId) {
        int idInt = int.parse(id);
        getUserChat(idInt);
      }
    } else
      print("Lista de ID Error!");

    return response;
  }

  Future<ChatUserModel?> getUserChat(int id) async {
    var url = Uri.parse('https://back-end-pdm.herokuapp.com/chat/getchat/');

    Map data = {
      "chat_id": id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      listaUser.add(ChatUserModel.fromJson(jsonDecode(response.body)));
      print("Tamanho: " + listaUser.length.toString());
      setState(() {});
      print("GetUser sucesso!");
      return ChatUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('GetUser Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   FocusManager.instance.primaryFocus?.unfocus();
      //   getListaChatId();
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: getTheme().colorScheme.primary,
          title: Text(
            "Minhas_Conversas".i18n(),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // if (listaUser.isEmpty)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 300.0),
            //     child: Container(
            //       height: 150,
            //       width: 300,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: getTheme().colorScheme.secondary,
            //       ),
            //       child: TextButton(
            //         child: Text(
            //           'Clique para carregar ou Inicie uma conversa!'.i18n(),
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               color: getTheme().colorScheme.onPrimary,
            //               fontSize: 28,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         onPressed: (() {
            //           getListaChatId();
            //         }),
            //         // style: TextButton.styleFrom(
            //         //     backgroundColor: getTheme().colorScheme.secondary),
            //       ),
            //       // child: Text(
            //       //     "Clique na tela para carregar ou Inicie uma conversa!",
            //       //     textAlign: TextAlign.center,
            //       //     style: TextStyle(
            //       //         fontSize: 35,
            //       //         fontWeight: FontWeight.bold,
            //       //         color: getTheme().colorScheme.onPrimaryContainer)),
            //     ),
            //   ),
            SizedBox(height: 30),
            if (listaUser.isNotEmpty)
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (ChatUserModel chat in listaUser)
                          ChatItem(
                            token: token!,
                            email: email,
                            userChat: chat,
                          ),
                      ],
                    ),
                  ),
                ],
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
