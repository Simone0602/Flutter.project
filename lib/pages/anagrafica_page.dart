import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:progetto/classi/studente.dart';
import 'package:progetto/service/httpService.dart';

import '../classi/docente.dart';
import '../component/textArea.dart';

class AnagraficaPage extends StatefulWidget {

  final dynamic user;
  final String utenza;
  
  AnagraficaPage(this.user, this.utenza, {Key? key}) : super(key: key);

  @override
  State<AnagraficaPage> createState() => _AnagraficaPageState();
}

class _AnagraficaPageState extends State<AnagraficaPage> {

  HttpService httpService = HttpService();

  late  TextEditingController userController; 
  late  TextEditingController passwordController; 
  late  TextEditingController mailController; 
  late  TextEditingController nomeController;
  late  TextEditingController cognomeController; 
  late  TextEditingController sezioneController;
  late  TextEditingController codfController;
  late  TextEditingController materieController;
  bool enabled = false;
  bool use = false;
  Icon icona = Icon(Icons.edit);

  @override
  void initState() {
    print("ciao3");
    if(widget.utenza == "studente"){
      setState(() {
      use = false;        
      });
    }else{
      setState(() {
      use = true;        
      });
    }
    //print(widget.user);
    if(use){
      passwordController = TextEditingController(text: widget.user.password);
      mailController = TextEditingController(text: widget.user.mail);
      nomeController = TextEditingController(text: widget.user.nome);
      cognomeController = TextEditingController(text: widget.user.cognome);
      sezioneController = TextEditingController(text: widget.user.sezioni);
      codfController = TextEditingController(text: widget.user.codiceFiscale);
      materieController = TextEditingController(text: widget.user.materie);
    }else{
      userController = TextEditingController(text: widget.user.userCode);
      passwordController = TextEditingController(text: widget.user.password);
      mailController = TextEditingController(text: widget.user.mail);
      nomeController = TextEditingController(text: widget.user.nome);
      cognomeController = TextEditingController(text: widget.user.cognome);
      sezioneController = TextEditingController(text: widget.user.sezione);
    }
    super.initState();
  }
  


  void updateUser() async {

      if (use) {
        Docente docente = Docente.allParams(codfController.text, passwordController.text, nomeController.text, cognomeController.text, mailController.text, sezioneController.text, materieController.text);
        await httpService.updateDocente(docente);
      } else {
        Studente studente = Studente.allParams(userController.text, passwordController.text, nomeController.text, cognomeController.text, mailController.text, sezioneController.text);
        await httpService.updateStudente(studente);
      }

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          "A N A G R A F I C A",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: icona,
            onPressed: () {
              setState(() {
                icona = enabled?
                        Icon(Icons.edit):
                        Icon(Icons.save);
                enabled = !enabled;

                if(!enabled){
                  updateUser();
                }
              });
              }
            ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              const SizedBox(height: 25),
               
               use?
               TextArea(
                controller: codfController,
                hintText: widget.user.codiceFiscale,
                obscureText: false,
                enable: false,
               ):TextArea(
                controller: userController,
                hintText: widget.user.userCode,
                obscureText: false,
                enable: false,
               ),

                
               SizedBox(height: 10),
                
                
               //mail solo per il docente
                TextArea(
                  controller: mailController,
                  hintText: widget.user.mail,
                  obscureText: false,
                  enable: enabled,
                ),

               SizedBox(height: 10),

              //password
               TextArea(
                controller: passwordController,
                hintText: "**********",
                obscureText: true,
                enable: enabled,
               ),

               SizedBox(height: 10),
               
              //nome
               TextArea(
                controller: nomeController,
                hintText: widget.user.nome,
                obscureText: false,
                enable: false,
               ),

               SizedBox(height: 10),
               
              //cognome
               TextArea(
                controller: cognomeController,
                hintText: widget.user.cognome,
                obscureText: false,
                enable: false,
               ),

               SizedBox(height: 10),
               
               use?
              //sezione
               TextArea(
                controller: sezioneController,
                hintText: widget.user.sezioni,
                obscureText: false,
                enable: false,
               ):TextArea(
                controller: sezioneController,
                hintText: widget.user.sezione,
                obscureText: false,
                enable: false,
               ),

               SizedBox(height: use? 10:0),
               
               use?
              //materie
              TextArea(
                controller: materieController,
                hintText: widget.user.materie,
                obscureText: false,
                enable: false,
               ):
               SizedBox(height: 0),
               

            ],
            ),
          ),
        ),
    );
  }
  
  

  
}