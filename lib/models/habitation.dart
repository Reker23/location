import 'dart:convert';

class Habitation {
  int id;
  TypeHabitat typeHabitat;
  String image;
  String libelle;
  String adresse;
  int nbpersonnes;
  int chambres;
  int superficie;
  double prixmois;
  int lits;
  int salleBains;
  List<Option> options;
  List<OptionPayante> optionpayantes;

  Habitation(this.id, this.typeHabitat, this.image, this.libelle, this.adresse,
      this.nbpersonnes, this.chambres, this.lits,this.salleBains,
      this.superficie, this.prixmois,
      {this.options = const[], this.optionpayantes = const[]});

  Habitation.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      typeHabitat = TypeHabitat.fromJson(json['typehabitat']),
      image = json['image'],
      libelle = json['libelle'],
      adresse = json['adresse'],
      nbpersonnes = json['habitantsmax'],
      chambres = json['chambres'],
      lits = json['lits'],
      salleBains = json['sdb'],
      superficie = json['superficie'],
      prixmois = json['prixmois'],
      options = (json['items'] as List)
        .map((item) => Option.fromJson(item))
        .toList(),
      optionpayantes = (json['optionpayantes'] as List)
        .map((item) => OptionPayante.fromJson(item))
        .toList();

}

class TypeHabitat{
  int id;
  String libelle;

  TypeHabitat(this.id, this.libelle);

  TypeHabitat.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    libelle = json['libelle'];
}

class HabitationService {
  var _typehabitats = [TypeHabitat(1, "Maison"), TypeHabitat(2, "Appartement")];

  var _habitations = List.generate(30, (index) {
    bool maison = index % 3 == 0;
    return Habitation(
        index,

        maison ? TypeHabitat(1, "Maison") : TypeHabitat(2, "Appartement"),
        maison ? "maison.png" : "appartement.png",
        "${maison ? 'Maison' : 'Appartement'} ${index}",
        "Rue ${index}",
        2 + index % 3,
        2 + index % 2,
        (maison ? 100 : 50) + index,
        ((maison ? 600 : 400) + index).toDouble());
  });

  List<TypeHabitat> getTypeHabitats() {
    return _typehabitats;
  }

  List<Habitation> getHabitationsTop10() {
    return _habitations
        .where((element) => element.id%2 == 1)
        .take(10)
        .toList();
  }

  List<Habitation> getMaisons() {
    return _getHabitations(isHouse: true);
  }

  List<Habitation> getAppartements() {
    return _getHabitations(isHouse: true);
  }

  List<Habitation> _getHabitations({bool isHouse = true}) {
    return _habitations
        .where((element) => element.typeHabitat.id == (isHouse ? 1 : 2 ))
        .toList();
  }
}


class Option {
  int id;
  String libelle;
  String description;

  Option(this.id, this.libelle, {this.description = ""});
}
class OptionPayante extends Option {
  double prix;

  OptionPayante(super.id, super.libelle, {super.description = "", this.prix = 0});
}