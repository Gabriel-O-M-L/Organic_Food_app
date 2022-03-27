import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REQUEST FOR API REST'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var url = Uri.parse('http://127.0.0.1:8000/back');
            http.Response response = await http.get(url);
            final decode = json.decode(response.body) as Map<String, dynamic>;
          },
          child: const Text("REQUEST DATA FROM API BACKEND"),
        ),
      ),
    );
  }
}
