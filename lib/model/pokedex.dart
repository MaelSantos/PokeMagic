import 'package:poke_magic/model/weaknesses.dart';

class Pokedex {
  List<Pokemon> pokemons;

  static final Pokedex _instance = Pokedex.internal();
  factory Pokedex() => _instance;
  Pokedex.internal();

  static Pokedex fromJson(List<dynamic> json) {
    _instance.pokemons = List();
    for (dynamic j in json) _instance.pokemons.add(Pokemon.fromJson(j));
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.pokemons != null) {
      for (int i = 1; i <= pokemons.length; i++)
        data['$i'] = this.pokemons[i].toJson();
    }
    return data;
  }

  Pokemon toPokemon(String poke) {
    try {
      return pokemons
          .firstWhere((p) => p.name.toLowerCase() == poke.toLowerCase());
    } catch (e) {
      return null;
    }
  }
}

class Pokemon {
  String number;
  int id;
  String name;
  double height;
  double weight;
  String generation;
  List<String> types;
  List<Abilities> abilities;
  List<Stats> stats;
  PokeMoves moves;
  Weakness weakness;

  Pokemon(
      {this.number,
      this.id,
      this.name,
      this.height,
      this.weight,
      this.types,
      this.abilities,
      this.stats,
      this.moves});

  String toString() => "$name";

  Pokemon.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    id = json['id'];
    name = json['name'];
    height = json['height'].toDouble();
    weight = json['weight'].toDouble();
    generation = json['generation'];
    types = json['types'].cast<String>();
    if (json['abilities'] != null) {
      abilities = List<Abilities>();
      json['abilities'].forEach((v) {
        abilities.add(Abilities.fromJson(v));
      });
    }
    if (json['stats'] != null) {
      stats = List<Stats>();
      json['stats'].forEach((v) {
        stats.add(Stats.fromJson(v));
      });
    }
    moves = json['moves'] != null ? PokeMoves.fromJson(json['moves']) : null;

    weakness = Weaknesses().toPokeWeakness(this);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['id'] = this.id;
    data['name'] = this.name;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['generation'] = generation;
    data['types'] = this.types;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.map((v) => v.toJson()).toList();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.moves != null) {
      data['moves'] = this.moves.toJson();
    }
    return data;
  }
}

class Abilities {
  String ability;
  bool isHidden;

  Abilities({this.ability, this.isHidden});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability = json['ability'];
    isHidden = json['is_hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ability'] = this.ability;
    data['is_hidden'] = this.isHidden;
    return data;
  }
}

class Stats {
  String stat;
  int baseStat;
  int ev;

  Stats({this.stat, this.baseStat, this.ev});

  Stats.fromJson(Map<String, dynamic> json) {
    stat = json['stat'];
    baseStat = json['base_stat'];
    ev = json['ev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stat'] = this.stat;
    data['base_stat'] = this.baseStat;
    data['ev'] = this.ev;
    return data;
  }
}

class PokeMoves {
  List<PokeMove> level;
  List<PokeMove> machine;
  List<PokeMove> egg;
  List<PokeMove> tutor;
  List<PokeMove> get all => _all();

  PokeMoves({this.level, this.machine, this.egg, this.tutor});

  List<PokeMove> _all() {
    List<PokeMove> all = List();
    all.addAll(level);
    all.addAll(machine);
    all.addAll(egg);
    all.addAll(tutor);
    return all;
  }

  PokeMoves.fromJson(Map<String, dynamic> json) {
    if (json['level'] != null) {
      level = List<PokeMove>();
      json['level'].forEach((v) {
        level.add(PokeMove.fromJson(v));
      });
    }
    if (json['machine'] != null) {
      machine = List<PokeMove>();
      json['machine'].forEach((v) {
        machine.add(PokeMove.fromJson(v));
      });
    }
    if (json['egg'] != null) {
      egg = List<PokeMove>();
      json['egg'].forEach((v) {
        egg.add(PokeMove.fromJson(v));
      });
    }
    if (json['tutor'] != null) {
      tutor = List<PokeMove>();
      json['tutor'].forEach((v) {
        tutor.add(PokeMove.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.level != null) {
      data['level'] = this.level.map((v) => v.toJson()).toList();
    }
    if (this.machine != null) {
      data['machine'] = this.machine.map((v) => v.toJson()).toList();
    }
    if (this.egg != null) {
      data['egg'] = this.egg.map((v) => v.toJson()).toList();
    }
    if (this.tutor != null) {
      data['tutor'] = this.tutor.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokeMove {
  String move;
  int level;
  String method;

  PokeMove({this.move, this.level, this.method});

  PokeMove.fromJson(Map<String, dynamic> json) {
    move = json['move'];
    level = json['level'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['move'] = this.move;
    data['level'] = this.level;
    data['method'] = this.method;
    return data;
  }
}
