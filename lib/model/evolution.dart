import 'package:poke_magic/model/comum.dart';

class Evolution {
  String babyTriggerItem;
  Chain chain;
  int id;

  Evolution({this.babyTriggerItem, this.chain, this.id});

  Evolution.fromJson(Map<String, dynamic> json) {
    babyTriggerItem = json['baby_trigger_item'].toString(); //corrigir
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baby_trigger_item'] = this.babyTriggerItem;
    if (this.chain != null) {
      data['chain'] = this.chain.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Chain {
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Trigger species;

  Chain({this.evolvesTo, this.isBaby, this.species});

  Chain.fromJson(Map<String, dynamic> json) {
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolvesTo {
  List<EvolutionDetails> evolutionDetails;
  List<EvolvesToTo> evolvesToTo;
  bool isBaby;
  Trigger species;

  EvolvesTo(
      {this.evolutionDetails, this.evolvesToTo, this.isBaby, this.species});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = new List<EvolutionDetails>();
      json['evolution_details'].forEach((v) {
        evolutionDetails.add(new EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesToTo = new List<EvolvesToTo>();
      json['evolves_to'].forEach((v) {
        evolvesToTo.add(new EvolvesToTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails.map((v) => v.toJson()).toList();
    }
    if (this.evolvesToTo != null) {
      data['evolves_to'] = this.evolvesToTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolutionDetails {
  int gender; //não string
  Comum heldItem;
  Comum item;
  Comum knownMove;
  Comum knownMoveType;
  Comum location;
  int minAffection; //não string
  int minBeauty; //não string
  int minHappiness;
  int minLevel;
  bool needsOverworldRain;
  Comum partySpecies;
  String partyType;
  int relativePhysicalStats; //não  string
  String timeOfDay;
  String tradeSpecies;
  Trigger trigger;
  bool turnUpsideDown;

  EvolutionDetails(
      {this.gender,
      this.heldItem,
      this.item,
      this.knownMove,
      this.knownMoveType,
      this.location,
      this.minAffection,
      this.minBeauty,
      this.minHappiness,
      this.minLevel,
      this.needsOverworldRain,
      this.partySpecies,
      this.partyType,
      this.relativePhysicalStats,
      this.timeOfDay,
      this.tradeSpecies,
      this.trigger,
      this.turnUpsideDown});

  EvolutionDetails.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    heldItem =
        json['held_item'] != null ? Comum.fromJson(json['held_item']) : null;
    item = json['item'] != null ? Comum.fromJson(json['item']) : null;
    knownMove =
        json['known_move'] != null ? Comum.fromJson(json['known_move']) : null;
    knownMoveType = json['known_move_type'] != null
        ? Comum.fromJson(json['known_move_type'])
        : null;
    location =
        json['location'] != null ? Comum.fromJson(json['location']) : null;
    minAffection = json['min_affection'];
    minBeauty = json['min_beauty'];
    minHappiness = json['min_happiness'];
    minLevel = json['min_level'];
    needsOverworldRain = json['needs_overworld_rain'];
    partySpecies =
        json['party_species'] != null ? Comum.fromJson(json['party_species']) : null;
    partyType = json['party_type'].toString(); //corrigir;
    relativePhysicalStats = json['relative_physical_stats'];
    timeOfDay = json['time_of_day'];
    tradeSpecies = json['trade_species'].toString(); //corrigir;
    trigger =
        json['trigger'] != null ? new Trigger.fromJson(json['trigger']) : null;
    turnUpsideDown = json['turn_upside_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['held_item'] = this.heldItem;
    data['item'] = this.item;
    data['known_move'] = this.knownMove;
    data['known_move_type'] = this.knownMoveType;
    data['location'] = this.location;
    data['min_affection'] = this.minAffection;
    data['min_beauty'] = this.minBeauty;
    data['min_happiness'] = this.minHappiness;
    data['min_level'] = this.minLevel;
    data['needs_overworld_rain'] = this.needsOverworldRain;
    data['party_species'] = this.partySpecies;
    data['party_type'] = this.partyType;
    data['relative_physical_stats'] = this.relativePhysicalStats;
    data['time_of_day'] = this.timeOfDay;
    data['trade_species'] = this.tradeSpecies;
    if (this.trigger != null) {
      data['trigger'] = this.trigger.toJson();
    }
    data['turn_upside_down'] = this.turnUpsideDown;
    return data;
  }
}

class Trigger {
  String name;
  String url;

  Trigger({this.name, this.url});

  Trigger.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class EvolvesToTo {
  List<EvolutionDetails> evolutionDetails;
  bool isBaby;
  Trigger species;

  EvolvesToTo({this.evolutionDetails, this.isBaby, this.species});

  EvolvesToTo.fromJson(Map<String, dynamic> json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = new List<EvolutionDetails>();
      json['evolution_details'].forEach((v) {
        evolutionDetails.add(new EvolutionDetails.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}
