import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/component/signButton.dart';
import 'package:progetto/component/textArea.dart';
import 'package:progetto/pages/home_page.dart';
import 'package:progetto/service/httpService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  _LoginPage();

  late bool cupSwitch = false;

  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final mailController = TextEditingController();
  HttpService httpService = HttpService();

  void SignIn() async {
    try {
      // Effettua la chiamata HTTP per il login
      print(cupSwitch);
      if (cupSwitch) {
        await httpService.loginDocente(userController.text, mailController.text, passwordController.text);
      } else {
        await httpService.loginStudente(userController.text, passwordController.text);
      }
      
      // Se la chiamata HTTP ha avuto successo, naviga alla nuova pagina
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Gestisci eventuali errori durante il login
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //logo
                SizedBox(height: cupSwitch? 15 : 30),
                
                const Icon(
                  Icons.account_circle,
                size:100,
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Studente',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                ),
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.grey[350],
                      onChanged: (bool value) { 
                      setState(() {
                      cupSwitch = value;
                    });}, value: cupSwitch,),
                    Text(
                      'Docente',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                ),
                    ),
                  ],
                  ),
                
                const SizedBox(height: 20),
                
              //welcome
                
              Text(
                'Benvenuto',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
                
              const SizedBox(height: 25),
                
              //username
               TextArea(
                controller: userController,
                hintText: cupSwitch? 'Codice Fiscale': 'Username',
                obscureText: false,
                enable: true,
               ),

                
               SizedBox(height: cupSwitch? 10: 5),
                
                cupSwitch?
               //mail solo per il docente
                TextArea(
                  controller: mailController,
                  hintText: 'Email',
                  obscureText: false,
                  enable: true,
                ): 
                SizedBox(),

               SizedBox(height: cupSwitch? 10: 5),
              //password
               TextArea(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                enable: true,
               ),
                
               const SizedBox(height: 10),
                
                
              //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Recupera Password',
                        style: TextStyle(color:Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: cupSwitch? 20 : 30),
                
              //sign in
                SignButton(
                  onTap: SignIn,
                ),
                
                const SizedBox(height: 30),
              //register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Non sei registrato?',
                      style: TextStyle(color: Colors.grey[700])
                      ),
                    const SizedBox(width: 4),
                    const Text(
                      'Registati ora',
                      style: TextStyle(
                        color:Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                  ],
                )
            ],
            ),
          ),
        ),
      )
    );
  }
}