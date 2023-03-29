import 'package:flutter/material.dart';
import 'package:progetto/classi/studente.dart';
import 'package:progetto/pages/login_page.dart';
import 'package:progetto/service/httpService.dart';

import '../pages/anagrafica_page.dart';
import '../pages/registro_page.dart';

class MenuHome extends StatefulWidget {

  final dynamic user;
  final String utenza;

  MenuHome(this.user, this.utenza, {super.key});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {

  bool use = false;

  HttpService service = HttpService();

  // method to log user out
  void logUserOut(BuildContext context) async {
    await service.logout();
    // go back to login page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.utenza + "ciao2");
    if(widget.utenza == "studente"){
      use = false;
    }else{
      use = true;
    }
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          // Drawer header
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  use?
                  "prof. " + widget.user.cognome + " " + widget.user.nome:
                  widget.user.cognome + " " + widget.user.nome,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.user.mail,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ANAGRAFICA BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: const Icon(Icons.portrait),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnagraficaPage(widget.user, widget.utenza),
                  ),
                );
              },
              title: Text(
                "A N A G R A F I C A",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),

          SizedBox(height: use? 25: 0),

          use?
          // registro BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: const Icon(Icons.book),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistroPage(widget.user, widget.utenza),
                  ),
                );
              },
              title: Text(
                "R E G I S T R O",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ):const SizedBox(height: 0),

          const SizedBox(height: 25),

          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              onTap: () => logUserOut(context),
              title: Text(
                "L O G O U T",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}