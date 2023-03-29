class Docente{
  late String codiceFiscale;
  late String password;
  late String nome;
  late String cognome;
  late String mail;
  late String sezioni;
  late String materie;

   factory Docente(){
    return Docente.allParams('', '', '', '', '', '', '');
  }

  Docente.fromJson(Map<String, dynamic> data){
    codiceFiscale = data['codiceFiscale'];
    password = data['password'];
    nome = data['nome'];
    cognome = data['cognome'];
    mail = data['mail'];
    sezioni = data['sezioni'].join(', ');
    materie = data['materie'].join(', ').toLowerCase();
  }

    Docente.allParams(this.codiceFiscale, this.password, this.nome, this.cognome, this.mail,
       this.sezioni, this.materie);

      Map<String, dynamic> toJson(){
        return {
          'codiceFiscale': codiceFiscale,
          'password': password,
          'nome': nome,
          'cognome': cognome,
          'mail': mail,
          'sezioni': sezioni.split(', '),
          'materie': materie.toUpperCase().split(', ')
        };
      }
}