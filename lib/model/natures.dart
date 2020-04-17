import 'package:poke_magic/model/comum.dart';

class Natures {

  List<Nature> natures;

  static final Natures _instance = Natures.internal();
  factory Natures() => _instance;
  Natures.internal();

  static Natures fromJson(Map<String, dynamic> json) {
    _instance.natures = List();
    for (dynamic j in json.values)
      _instance.natures.add(Nature.fromJson(j));
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.natures != null) {
      for (int i = 1; i <= natures.length; i++)
        data['$i'] = this.natures[i].toJson();
    }
    return data;
  }
}

class Nature {
  int id;
  String name;
  Comum decreasedStat;
  Comum hatesFlavor;
  Comum increasedStat;
  Comum likesFlavor;

  Nature(
      {this.decreasedStat,
      this.hatesFlavor,
      this.id,
      this.increasedStat,
      this.likesFlavor,
      this.name});

  Nature.fromJson(Map<String, dynamic> json) {
    decreasedStat = json['decreased_stat'] != null
        ? new Comum.fromJson(json['decreased_stat'])
        : null;
    hatesFlavor = json['hates_flavor'] != null
        ? new Comum.fromJson(json['hates_flavor'])
        : null;
    id = json['id'];
    increasedStat = json['increased_stat'] != null
        ? new Comum.fromJson(json['increased_stat'])
        : null;
    likesFlavor = json['likes_flavor'] != null
        ? new Comum.fromJson(json['likes_flavor'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.decreasedStat != null) {
      data['decreased_stat'] = this.decreasedStat.toJson();
    }
    if (this.hatesFlavor != null) {
      data['hates_flavor'] = this.hatesFlavor.toJson();
    }
    data['id'] = this.id;
    if (this.increasedStat != null) {
      data['increased_stat'] = this.increasedStat.toJson();
    }
    if (this.likesFlavor != null) {
      data['likes_flavor'] = this.likesFlavor.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}