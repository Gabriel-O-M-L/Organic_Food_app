import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdm/src/features/product/presentation/widget/footer.dart';
import 'package:pdm/src/features/userSpace/presentation/page/map.dart';
import '../../../auth/presentation/view/page/login.dart';
import '../../../search/presentation/view/page/search.dart';
import 'user.dart';
import 'package:pdm/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localization/localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyDjVyvOsvS2qsb2_ASvIFZRhAR-tjQmc3I";

class dadosPessoais extends StatefulWidget {
  final String? token;
  final String? email;

  const dadosPessoais({Key? key, this.token, this.email}) : super(key: key);
  @override
  State<dadosPessoais> createState() => _dadosPessoaisState(token, email);
}

class _dadosPessoaisState extends State<dadosPessoais> {
  final String? token;
  final String? email;

  TextEditingController nomeController = new TextEditingController();
  TextEditingController telefoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String nome = "";
  String numero = "";
  String emailf = "";
  String lats = "";
  String longs = "";

  double lat = 0;
  double long = 0;

  _dadosPessoaisState(this.token, this.email);

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    lats = lat.toString();
    longs = long.toString();
    print("Latitude: $lats and Longitude: $longs");
  }

  Future<http.Response> postRequest() async {
    print("token: " + token!);
    print("name: " + nome);
    print("email: " + email!);
    print("phone: " + numero);
    print("lat: " + lats);
    print("long: " + longs);

    var url = Uri.parse('https://back-end-pdm.herokuapp.com/user/personal/');

    Map data = {
      "jwt": token,
      "name": nome,
      "email": emailf,
      "phone": numero,
      "latitude": lats,
      "longitude": longs,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      alertDialog("Sucesso!", 1);
    } else
      alertDialog("Error!", 0);

    return response;
  }

  Future alertDialog(String text, int status) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.of(context).pop();
                if (status == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserScreen(token: token, email: email)),
                  );
                }
              },
            ),
          ],
          title: Text("Alerta".i18n(), style: TextStyle(fontSize: 28)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
                  //'Please rate with star',
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget get _buildFooter {
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
                          UserScreen(token: token, email: email)),
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
                          dadosPessoais(token: token, email: email)),
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

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: getTheme().colorScheme.primaryContainer,
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text('data'.i18n()),
          centerTitle: true,
          backgroundColor: Color(0xff388E3C),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 20),
                height: MediaQuery.of(context).size.height / 2,
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
                            onChanged: (text) {
                              getCurrentLocation();
                            },
                            decoration: InputDecoration(
                              labelText: "name".i18n(),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Color(0xffFFFFFF),
                              ),
                              filled: true,
                              fillColor: getTheme().colorScheme.tertiary,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: getTheme().colorScheme.tertiary,
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
                              labelText: "phone".i18n(),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: getTheme().colorScheme.onTertiary,
                              ),
                              filled: true,
                              fillColor: getTheme().colorScheme.tertiary,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: getTheme().colorScheme.tertiary,
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
                              labelText: "email".i18n(),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: getTheme().colorScheme.onTertiary,
                              ),
                              filled: true,
                              fillColor: getTheme().colorScheme.tertiary,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: getTheme().colorScheme.tertiary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () async {
                              nome = nomeController.text;
                              numero = telefoneController.text;
                              emailf = emailController.text;

                              postRequest();
                            },
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
                        ],
                      ),
                    ],
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
        // bottomSheet: _buildFooter,
      ),
    );
  }
}
