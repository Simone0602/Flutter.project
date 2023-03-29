import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../classi/assenza.dart';
import '../classi/classe.dart';
import '../classi/studente.dart';
import '../service/httpService.dart';

class RegistroPage extends StatefulWidget {
  final dynamic user;
  final String utenza;

  const RegistroPage(this.user, this.utenza, {Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  HttpService httpService = HttpService();
  String selezionaClasse = "Seleziona classe";

  List<Studente> studenti = [];
  bool attivo = false;
  List<Assenza> assenze = [];

  getStudenti(String sezione) async{
    List<Studente> studenti = await httpService.getStudentiClassi(sezione);
    attivo = true;
    for(var studente in studenti){
      Assenza assenza = Assenza(false, DateTime.now(), studente.userCode);
      assenze.add(assenza);
      print(studente.userCode);
    }
    setState(() {
      this.studenti = studenti;
    });
  }

  Future<void> _salva() async {
    String message = await httpService.saveAssenzeDocente(assenze);
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "R E G I S T R O",
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
        backgroundColor: Colors.grey[300],
         floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.save),
            onPressed: () => _salva()
            ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [
                  
                  DecoratedBox(
                    decoration: BoxDecoration(),
                    child: FutureBuilder(
                      future: httpService.getClassiDocente(widget.user),
                      builder: (context, snapshot){
                        List<Classe>  classi = snapshot.data??[];
                        return DropdownButton(
                  
                          isExpanded: true,
                          hint: Text(selezionaClasse), 
                          items: classi.map((classe) {
                            return DropdownMenuItem(
                              value: classe.sezione,
                              child: Text(classe.sezione),
                            );
                          }).toList(), 
                          onChanged: (value){
                            setState(() {
                              selezionaClasse = value!;
                              getStudenti(value);
                            });
                          }
                          );
                      }
                      ),
                  ),

                  attivo?
                  DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  "Nome",
                                  style: TextStyle(fontSize: 15),
                                )
                              )
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  "Assenze",
                                  style: TextStyle(fontSize: 15),
                                )
                              )
                            )
                          ], 
                          rows: List<DataRow>.generate(
                            studenti.length, 
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    studenti[index].nome,
                                  style: TextStyle(fontSize: 15),)
                                  ),
                                DataCell(
                                  Checkbox(
                                    value: assenze[index].giustificata,
                                    onChanged: (bool? value) {
                                        Assenza assenza = Assenza(!assenze[index].giustificata, DateTime.now(), studenti[index].userCode);
                                        setState(() {
                                          assenze[index] = assenza;
                                          print(assenze[index].userCode);
                                        });
                                      },)
                                )
                              ]
                              )
                            )
                          ):SizedBox(height: 0),
                ]
              ),
            )
        )
    );
  }
}
