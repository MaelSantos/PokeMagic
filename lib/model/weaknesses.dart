import 'package:poke_magic/model/pokedex.dart';

class Weaknesses {
  List<Weakness> weakness;

  static final Weaknesses _instance = Weaknesses.internal();
  factory Weaknesses() => _instance;
  Weaknesses.internal();

  static Weaknesses fromJson(Map<String, dynamic> json) {
    _instance.weakness = List();
    for (int i = 1; i <= json.length; i++)
      _instance.weakness
          .add(json['$i'] != null ? Weakness.fromJson(json['$i']) : null);
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weakness != null) {
      for (int i = 1; i <= weakness.length; i++)
        data['$i'] = this.weakness[i].toJson();
    }
    return data;
  }

  Weakness toWeakness(String t1) => weakness.firstWhere((w) => w.name == t1);

  Weakness toTwoWeakness(String t1, String t2) {
    Weakness type1 = toWeakness(t1);
    Weakness type2 = toWeakness(t2);

    Weakness type = Weakness(types: List());
    type.name = type1.name + " X " + type2.name;
    for (int i = 0; i < type1.types.length; i++) {
      type.types.add(Type(
          name: type1.types[i].name,
          damage: type1.types[i].damage * type2.types[i].damage));
    }
    return type;
  }

  Weakness toPokeWeakness(Pokemon pokemon) {
    return pokemon.types.length > 1
        ? toTwoWeakness(pokemon.types[1].type.name, pokemon.types[0].type.name)
        : toWeakness(pokemon.types[0].type.name);
  }
}

class Weakness {
  String name;
  List<Type> types;

  Weakness({this.name, this.types});

  Weakness.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['type'] != null) {
      types = new List<Type>();
      json['type'].forEach((v) {
        types.add(new Type.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.types != null) {
      data['type'] = this.types.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Type {
  String name;
  double damage;

  Type({this.name, this.damage});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    damage = json['damage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['damage'] = this.damage;
    return data;
  }
}
