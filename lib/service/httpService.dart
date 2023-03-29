import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:progetto/classi/assenza.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classi/classe.dart';
import '../classi/studente.dart';
import '../classi/docente.dart';

class HttpService{
  String url = 'http://192.168.1.2:8090';
  final Dio dio = Dio();
  late Studente studente;
  late Docente docente;

Future loginStudente(String username, String password) async {

//Serve per ricevere il token per il login dello studente
  final token = await dio.post('$url/auth/authenticate-student',
   data: {'userCode': username, 'password': password});
  
  //Serve per settare il token
  final store = await SharedPreferences.getInstance();
    return await store.setString('token', token.toString());

    
}

  Future loginDocente(String codiceFiscale, String mail, String password) async {

  //Serve per ricevere  il token per il login del docente
    final token = await dio.post('$url/auth/authenticate-docente',
      data: {'codiceFiscale': codiceFiscale, 'mail': mail, 'password': password});

    final store = await SharedPreferences.getInstance();
      return await store.setString('token', token.toString());
  }

  Future<Studente> getStudente(String token) async {
    final sub = _decodifica(token)['sub'];

    final options =
          Options(headers: {'Authorization': 'Bearer $token'});

    final studente = await dio.get<Map<String, dynamic>>('$url/studente/$sub/get-studente', options: options);

    return Studente.fromJson(studente.data!);
  }


  Future<Docente> getDocente(String token) async {
    final sub = _decodifica(token)['sub'];

    final options =
          Options(headers: {'Authorization': 'Bearer $token'});

    final docente = await dio.get<Map<String, dynamic>>('$url/docente/$sub/get-docente', options: options);

    print("ciao");
    print(docente.data);

    return Docente.fromJson(docente.data!);
  }

  Future<String?> updateStudente(Studente studente) async {

    final store = await SharedPreferences.getInstance();
    final jToken = await store.get('token');
    final token = json.decode(jToken.toString());

    final options =
          Options(headers: {'Authorization': 'Bearer ${token['token']}'});

          print(studente.toJson());

    final update = await dio.put('$url/studente/update', 
      data: studente.toJson(), options: options);
      print(update);
      return null;
  }

  Future<String?> updateDocente(Docente docente) async {

    final store = await SharedPreferences.getInstance();
    final jToken = await store.get('token');
    final token = json.decode(jToken.toString());

    final options =
          Options(headers: {'Authorization': 'Bearer ${token['token']}'});

          print(docente.toJson());

    final update = await dio.put('$url/docente/update', 
      data: docente.toJson(), options: options);
      print(update);
      return null;
  }

  Future<List<Classe>> getClassiDocente(Docente docente) async{
    final store = await SharedPreferences.getInstance();
    final jToken = await store.get('token');
    final token = json.decode(jToken.toString());
    final options = Options(headers: {'Authorization': 'Bearer ${token['token']}'});

    final getClassi = await dio.get('$url/docente/find/${docente.codiceFiscale}', options: options);

    return Classe.getListaClassi(getClassi.data);
  }


  Future<List<Studente>> getStudentiClassi(String sezione) async{
    final store = await SharedPreferences.getInstance();
    final jToken = await store.get('token');
    final token = json.decode(jToken.toString());
    final options = Options(headers: {'Authorization': 'Bearer ${token['token']}'});

    final getStudenti = await dio.get('$url/classe/$sezione/studenti', options: options);

    return Studente.getListaStudenti(getStudenti.data);
  }

  Future<String> saveAssenzeDocente(List<Assenza> assenze) async {
    final store = await SharedPreferences.getInstance();
    final jToken = await store.get('token');
    final token = json.decode(jToken.toString());
    final options = Options(headers: {'Authorization': 'Bearer ${token['token']}'}, contentType: 'application/json');

    final saveassenze = await dio.post('$url/docente/salva-assenze-studente', options: options, 
    data: assenze.map((assenza) {
      return assenza.toJson();
    }).toList()
    );

    return saveassenze.data;
  }

  Map<String,  dynamic> _decodifica(String token){
    return JwtDecoder.decode(token);
  }

  Future<bool> logout() async {
    final store = await SharedPreferences.getInstance();
    return await store.remove('token');
  }

}