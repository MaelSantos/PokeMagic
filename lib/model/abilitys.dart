import 'package:poke_magic/model/comum.dart';

class Abilitys {
  List<Ability> abilitys;

  static final Abilitys _instance = Abilitys.internal();
  factory Abilitys() => _instance;
  Abilitys.internal();

  static Abilitys fromJson(Map<String, dynamic> json) {
    _instance.abilitys = List();
    for (int i = 1; i <= json.length; i++)
      _instance.abilitys
          .add(json['$i'] != null ? Ability.fromJson(json['$i']) : null);
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilitys != null) {
      for (int i = 1; i <= abilitys.length; i++)
        data['$i'] = this.abilitys[i].toJson();
    }
    return data;
  }

  Ability toAbility(String nome) => abilitys.firstWhere((a) => a.name == nome);
}

class Ability {
  EffectChanges effectChanges;
  EffectEntries effectEntries;
  FlavorTextEntries flavorTextEntries;
  Comum generation;
  int id;
  bool isMainSeries;
  String name;
  List<AbilityPokemon> pokemon;
  String num;

  Ability(
      {this.effectChanges,
      this.effectEntries,
      this.flavorTextEntries,
      this.generation,
      this.id,
      this.isMainSeries,
      this.name,
      this.pokemon,
      this.num});

  Ability.fromJson(Map<String, dynamic> json) {
    effectChanges = json['effect_changes'] != null
        ? new EffectChanges.fromJson(json['effect_changes'])
        : null;
    effectEntries = json['effect_entries'] != null
        ? new EffectEntries.fromJson(json['effect_entries'])
        : null;
    flavorTextEntries = json['flavor_text_entries'] != null
        ? new FlavorTextEntries.fromJson(json['flavor_text_entries'])
        : null;
    generation = json['generation'] != null
        ? new Comum.fromJson(json['generation'])
        : null;
    id = json['id'];
    isMainSeries = json['is_main_series'];
    name = json['name'];
    if (json['pokemon'] != null) {
      pokemon = new List<AbilityPokemon>();
      json['pokemon'].forEach((v) {
        pokemon.add(new AbilityPokemon.fromJson(v));
      });
    }
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.effectChanges != null) {
      data['effect_changes'] = this.effectChanges.toJson();
    }
    if (this.effectEntries != null) {
      data['effect_entries'] = this.effectEntries.toJson();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] = this.flavorTextEntries.toJson();
    }
    if (this.generation != null) {
      data['generation'] = this.generation.toJson();
    }
    data['id'] = this.id;
    data['is_main_series'] = this.isMainSeries;
    data['name'] = this.name;
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.map((v) => v.toJson()).toList();
    }
    data['num'] = this.num;
    return data;
  }
}

class EffectChanges {
  String effect;

  EffectChanges({this.effect});

  EffectChanges.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effect'] = this.effect;
    return data;
  }
}

class EffectEntries {
  String effect;
  String shortEffect;

  EffectEntries({this.effect, this.shortEffect});

  EffectEntries.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    shortEffect = json['short_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effect'] = this.effect;
    data['short_effect'] = this.shortEffect;
    return data;
  }
}

class FlavorTextEntries {
  String flavorText;

  FlavorTextEntries({this.flavorText});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;
    return data;
  }
}

class AbilityPokemon {
  bool isHidden;
  Comum pokemon;
  int slot;

  AbilityPokemon({this.isHidden, this.pokemon, this.slot});

  AbilityPokemon.fromJson(Map<String, dynamic> json) {
    isHidden = json['is_hidden'];
    pokemon =
        json['pokemon'] != null ? new Comum.fromJson(json['pokemon']) : null;
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_hidden'] = this.isHidden;
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    data['slot'] = this.slot;
    return data;
  }
}
