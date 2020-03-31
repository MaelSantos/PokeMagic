import 'package:poke_magic/model/comum.dart';

class Locations {
  List<Location> locations;

  static final Locations _instance = Locations.internal();
  factory Locations() => _instance;
  Locations.internal();

  static Locations fromJson(Map<String, dynamic> json) {
    _instance.locations = List();
    for (dynamic j in json.values)
      _instance.locations.add(Location.fromJson(j));
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.locations != null) {
      for (int i = 1; i <= locations.length; i++)
        data['$i'] = this.locations[i].toJson();
    }
    return data;
  }
}

class Location {
  int gameIndex;
  int id;
  Comum location;
  String name;
  List<PokemonEncounters> pokemonEncounters;

  Location(
      {this.gameIndex,
      this.id,
      this.location,
      this.name,
      this.pokemonEncounters});

  Location.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
    id = json['id'];
    location =
        json['location'] != null ? Comum.fromJson(json['location']) : null;
    name = json['name'];
    if (json['pokemon_encounters'] != null) {
      pokemonEncounters = List<PokemonEncounters>();
      json['pokemon_encounters'].forEach((v) {
        pokemonEncounters.add(PokemonEncounters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['game_index'] = this.gameIndex;
    data['id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['name'] = this.name;
    if (this.pokemonEncounters != null) {
      data['pokemon_encounters'] =
          this.pokemonEncounters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonEncounters {
  Comum pokemon;
  VersionDetails versionDetails;

  PokemonEncounters({this.pokemon, this.versionDetails});

  PokemonEncounters.fromJson(Map<String, dynamic> json) {
    pokemon = json['pokemon'] != null ? Comum.fromJson(json['pokemon']) : null;

    versionDetails = json['version_details'] != null
        ? VersionDetails.fromJson(json['version_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    if (this.versionDetails != null) {
      data['version_details'] = this.versionDetails.toJson();
    }
    return data;
  }
}

class VersionDetails {
  List<EncounterDetails> encounterDetails;
  int maxChance;
  Comum version;

  VersionDetails({this.encounterDetails, this.maxChance, this.version});

  VersionDetails.fromJson(Map<String, dynamic> json) {
    if (json['encounter_details'] != null) {
      encounterDetails = List<EncounterDetails>();
      json['encounter_details'].forEach((v) {
        encounterDetails.add(EncounterDetails.fromJson(v));
      });
    }
    maxChance = json['max_chance'];
    version = json['version'] != null ? Comum.fromJson(json['version']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.encounterDetails != null) {
      data['encounter_details'] =
          this.encounterDetails.map((v) => v.toJson()).toList();
    }
    data['max_chance'] = this.maxChance;
    if (this.version != null) {
      data['version'] = this.version.toJson();
    }
    return data;
  }
}

class EncounterDetails {
  int chance;
  List<Comum> conditionValues;
  int maxLevel;
  Comum method;
  int minLevel;

  EncounterDetails(
      {this.chance,
      this.conditionValues,
      this.maxLevel,
      this.method,
      this.minLevel});

  EncounterDetails.fromJson(Map<String, dynamic> json) {
    chance = json['chance'];
    if (json['condition_values'] != null) {
      conditionValues = List<Comum>();
      json['condition_values'].forEach((v) {
        conditionValues.add(Comum.fromJson(v)); //arrumar depois
      });
    }
    maxLevel = json['max_level'];
    method = json['method'] != null ? Comum.fromJson(json['method']) : null;
    minLevel = json['min_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chance'] = this.chance;
    if (this.conditionValues != null) {
      data['condition_values'] =
          this.conditionValues.map((v) => v.toJson()).toList(); //arrumar depois
    }
    data['max_level'] = this.maxLevel;
    if (this.method != null) {
      data['method'] = this.method.toJson();
    }
    data['min_level'] = this.minLevel;
    return data;
  }
}
