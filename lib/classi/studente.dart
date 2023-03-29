class Studente{
  late String? userCode;
  late String? password;
  late String nome;
  late String cognome;
  late String mail;
  late String sezione;

   factory Studente(){
    return Studente.allParams('', '', '', '', '', '');
  }

  Studente.fromJson(Map<String, dynamic> data){
    userCode = data['userCode'];
    password = data['password'];
    nome = data['nome'];
    cognome = data['cognome'];
    mail = data['mail'];
    sezione = data['sezione'];
  }

  Studente.allParams( this.userCode, this.password, this.nome, this.cognome, this.mail,
       this.sezione);

  Map<String, dynamic> toJson(){
    return {
      'userCode': userCode,
      'password': password,
      'nome': nome,
      'cognome': cognome,
      'mail': mail,
      'sezione': sezione
    };
  }

  static List<Studente> getListaStudenti(dynamic response){
    List<Studente> studente = [];
    for(var item in response){
      studente.add(Studente.fromJson(item));
    }
    return studente;
  }
}