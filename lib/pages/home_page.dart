import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:progetto/classi/docente.dart';
import 'package:progetto/classi/studente.dart';
import 'package:progetto/component/menuHome.dart';
import 'package:progetto/service/httpService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  HttpService httpService = HttpService();

  String utenza = " ";
  late Studente studente = Studente();
  late Docente docente = Docente();
  late bool bol = false;

  @override
  void initState() {
    init();
    super.initState();   
  }

  Future<void> init() async {
    final store = await SharedPreferences.getInstance();
    final jsonToken = store.get('token');

    final token = json.decode(jsonToken.toString());

    print(token);

    print(token["utenza"]);

    utenza = token["utenza"];

    if(utenza == "studente"){
      studente = (await httpService.getStudente(token['token']));
      setState(() {
        studente = studente;
      });
    }else{
      docente = (await httpService.getDocente(token['token']));
      setState(() {
        docente = docente;
      });
      bol = true;
    }

    print(utenza + "ciao1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade800,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          "Nome Scuola",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 15,
            ),
        ),
      ),
      drawer: MenuHome(getUser(), utenza),
      );
  }

  dynamic getUser(){
    return bol?
    docente : studente;
  }
}