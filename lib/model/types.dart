import 'package:poke_magic/model/comum.dart';

class Types {
  List<Type> types;

  static final Types _instance = Types.internal();
  factory Types() => _instance;

  Types.internal();

  static Types fromJson(Map<String, dynamic> json) {
    _instance.types = List();
    for (int i = 1; i <= json.length; i++)
      _instance.types
          .add(json['$i'] != null ? Type.fromJson(json['$i']) : null);
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      for (int i = 1; i <= types.length; i++)
        data['$i'] = this.types[i].toJson();
    }
    return data;
  }

  Type toType(String name) => types.firstWhere((t)=> t.name == name);
}

class Type {
  DamageRelations damageRelations;
  Comum generation;
  int id;
  Comum moveDamageClass;
  String name;

  Type(
      {this.damageRelations,
      this.generation,
      this.id,
      this.moveDamageClass,
      this.name});

  Type.fromJson(Map<String, dynamic> json) {
    damageRelations = json['damage_relations'] != null
        ? new DamageRelations.fromJson(json['damage_relations'])
        : null;
    generation = json['generation'] != null
        ? new Comum.fromJson(json['generation'])
        : null;
    id = json['id'];
    moveDamageClass = json['move_damage_class'] != null
        ? new Comum.fromJson(json['move_damage_class'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.damageRelations != null) {
      data['damage_relations'] = this.damageRelations.toJson();
    }
    if (this.generation != null) {
      data['generation'] = this.generation.toJson();
    }
    data['id'] = this.id;
    if (this.moveDamageClass != null) {
      data['move_damage_class'] = this.moveDamageClass.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class DamageRelations {
  List<Comum> doubleDamageFrom;
  List<Comum> doubleDamageTo;
  List<Comum> halfDamageFrom;
  List<Comum> halfDamageTo;
  List<Comum> noDamageFrom;
  List<Comum> noDamageTo;

  DamageRelations(
      {this.doubleDamageFrom,
      this.doubleDamageTo,
      this.halfDamageFrom,
      this.halfDamageTo,
      this.noDamageFrom,
      this.noDamageTo});

  DamageRelations.fromJson(Map<String, dynamic> json) {
    if (json['double_damage_from'] != null) {
      doubleDamageFrom = new List<Comum>();
      json['double_damage_from'].forEach((v) {
        doubleDamageFrom.add(new Comum.fromJson(v));
      });
    }
    if (json['double_damage_to'] != null) {
      doubleDamageTo = new List<Comum>();
      json['double_damage_to'].forEach((v) {
        doubleDamageTo.add(new Comum.fromJson(v));
      });
    }
    if (json['half_damage_from'] != null) {
      halfDamageFrom = new List<Comum>();
      json['half_damage_from'].forEach((v) {
        halfDamageFrom.add(new Comum.fromJson(v));
      });
    }
    if (json['half_damage_to'] != null) {
      halfDamageTo = new List<Comum>();
      json['half_damage_to'].forEach((v) {
        halfDamageTo.add(new Comum.fromJson(v));
      });
    }
    if (json['no_damage_from'] != null) {
      noDamageFrom = new List<Comum>();
      json['no_damage_from'].forEach((v) {
        noDamageFrom.add(new Comum.fromJson(v));
      });
    }
    if (json['no_damage_to'] != null) {
      noDamageTo = new List<Comum>();
      json['no_damage_to'].forEach((v) {
        noDamageTo.add(new Comum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doubleDamageFrom != null) {
      data['double_damage_from'] =
          this.doubleDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.doubleDamageTo != null) {
      data['double_damage_to'] =
          this.doubleDamageTo.map((v) => v.toJson()).toList();
    }
    if (this.halfDamageFrom != null) {
      data['half_damage_from'] =
          this.halfDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.halfDamageTo != null) {
      data['half_damage_to'] =
          this.halfDamageTo.map((v) => v.toJson()).toList();
    }
    if (this.noDamageFrom != null) {
      data['no_damage_from'] =
          this.noDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.noDamageTo != null) {
      data['no_damage_to'] = this.noDamageTo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
