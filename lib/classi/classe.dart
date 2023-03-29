class Classe{
  late String sezione;
  late String cordinatore;
  late String aula;

  Classe();

  Classe.fromJson(Map<String, dynamic> data){
    sezione = data['sezione'];
    cordinatore = data['cordinatore'];
    aula = data['aula'];
  }

  Map<String, dynamic> toJson(){
    return {
      'sezione': sezione,
      'cordinatore': cordinatore,
      'aula': aula,
    };
  }

  static List<Classe> getListaClassi(dynamic response){
    List<Classe> classi = [];
    for(var item in response){
      classi.add(Classe.fromJson(item));
    }
    return classi;
  }
}