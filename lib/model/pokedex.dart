import 'package:poke_magic/model/comum.dart';

class Pokedex {
  List<Pokemon> pokemons;

  static final Pokedex _instance = Pokedex.internal();
  factory Pokedex() => _instance;
  Pokedex.internal();

  static Pokedex fromJson(Map<String, dynamic> json) {
    _instance.pokemons = List();
    for (int i = 1; i <= json.length; i++)
      _instance.pokemons
          .add(json['$i'] != null ? Pokemon.fromJson(json['$i']) : null);
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemons != null) {
      for (int i = 1; i <= pokemons.length; i++)
        data['$i'] = this.pokemons[i].toJson();
    }
    return data;
  }

  Pokemon toPokemon(String poke) {
    try {
      return pokemons.firstWhere((p) => poke.contains(p.name));
    } catch (e) {
      return null;
    }
  }
}

class Pokemon {
  List<PokemonAbilities> abilities;
  int baseExperience;
  List<Comum> forms;
  int height;
  int id;
  List<PokemonMove> moves;
  String name;
  List<Stats> stats;
  List<PokemonTypes> types;
  int weight;
  String number;

  Pokemon(
      {this.abilities,
      this.baseExperience,
      this.forms,
      this.height,
      this.id,
      this.moves,
      this.name,
      this.stats,
      this.types,
      this.weight,
      this.number});

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = new List<PokemonAbilities>();
      json['abilities'].forEach((v) {
        abilities.add(new PokemonAbilities.fromJson(v));
      });
    }
    baseExperience = json['base_experience'];
    if (json['forms'] != null) {
      forms = new List<Comum>();
      json['forms'].forEach((v) {
        forms.add(new Comum.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    if (json['moves'] != null) {
      moves = new List<PokemonMove>();
      json['moves'].forEach((v) {
        moves.add(new PokemonMove.fromJson(v));
      });
    }
    name = json['name'];
    if (json['stats'] != null) {
      stats = new List<Stats>();
      json['stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = new List<PokemonTypes>();
      json['types'].forEach((v) {
        types.add(new PokemonTypes.fromJson(v));
      });
    }
    weight = json['weight'];
    number = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities.map((v) => v.toJson()).toList();
    }
    data['base_experience'] = this.baseExperience;
    if (this.forms != null) {
      data['forms'] = this.forms.map((v) => v.toJson()).toList();
    }
    data['height'] = this.height;
    data['id'] = this.id;
    if (this.moves != null) {
      data['moves'] = this.moves.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['num'] = this.number;
    return data;
  }
}

class PokemonAbilities {
  Comum ability;
  bool isHidden;
  int slot;

  PokemonAbilities({this.ability, this.isHidden, this.slot});

  PokemonAbilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? new Comum.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ability != null) {
      data['ability'] = this.ability.toJson();
    }
    data['is_hidden'] = this.isHidden;
    data['slot'] = this.slot;
    return data;
  }
}

class PokemonMove {
  Comum move;
  VersionGroupDetails versionGroupDetails;

  PokemonMove({this.move});

  PokemonMove.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? new Comum.fromJson(json['move']) : null;

    versionGroupDetails = json['version_group_details'] != null
        ? new VersionGroupDetails.fromJson(json['version_group_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.move != null) {
      data['move'] = this.move.toJson();
      data['version_group_details'] = this.versionGroupDetails.toJson();
    }
    return data;
  }
}

class VersionGroupDetails {
  int levelLearnedAt;
  Comum moveLearnMethod;

  VersionGroupDetails({this.levelLearnedAt, this.moveLearnMethod});

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = json['move_learn_method'] != null
        ? new Comum.fromJson(json['move_learn_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_learned_at'] = this.levelLearnedAt;
    if (this.moveLearnMethod != null) {
      data['move_learn_method'] = this.moveLearnMethod.toJson();
    }
    return data;
  }
}

class Stats {
  int baseStat;
  int effort;
  Comum stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? new Comum.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat.toJson();
    }
    return data;
  }
}

class PokemonTypes {
  int slot;
  Comum type;

  PokemonTypes({this.slot, this.type});

  PokemonTypes.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Comum.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}
