import 'package:poke_magic/model/comum.dart';

class Moves {
  List<Move> moves;

  static final Moves _instance = Moves.internal();
  factory Moves() => _instance;
  Moves.internal();

  static Moves fromJson(Map<String, dynamic> json) {
    _instance.moves = List();
    for (int i = 1; i <= json.length; i++)
      _instance.moves
          .add(json['$i'] != null ? Move.fromJson(json['$i']) : null);
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.moves != null) {
      for (int i = 1; i <= moves.length; i++)
        data['$i'] = this.moves[i].toJson();
    }
    return data;
  }

  Move toMove(String nome) => moves.firstWhere((m) => m.name == nome);
}

class Move {
  int nivel = 0;
  String tipo;

  int accuracy;
  ContestCombos contestCombos;
  ContestEffect contestEffect;
  Comum contestType;
  Comum damageClass;
  int effectChance;
  List<String> effectChanges;
  List<EffectEntries> effectEntries;
  FlavorTextEntries flavorTextEntries;
  int id;
  List<String> machines;
  Meta meta;
  String name;
  List<PastValues> pastValues;
  int power;
  int pp;
  int priority;
  List<String> statChanges;
  Comum target;
  Comum type;

  Move(
      {this.accuracy,
      this.contestCombos,
      this.contestEffect,
      this.contestType,
      this.damageClass,
      this.effectChance,
      this.effectChanges,
      this.effectEntries,
      this.flavorTextEntries,
      this.id,
      this.machines,
      this.meta,
      this.name,
      this.pastValues,
      this.power,
      this.pp,
      this.priority,
      this.statChanges,
      this.target,
      this.type});

  Move.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    contestCombos = json['contest_combos'] != null
        ? new ContestCombos.fromJson(json['contest_combos'])
        : null;
    contestEffect = json['contest_effect'] != null
        ? new ContestEffect.fromJson(json['contest_effect'])
        : null;
    contestType = json['contest_type'] != null
        ? new Comum.fromJson(json['contest_type'])
        : null;
    damageClass = json['damage_class'] != null
        ? new Comum.fromJson(json['damage_class'])
        : null;
    effectChance = json['effect_chance'];
    if (json['effect_changes'] != null) {
      effectChanges = new List<String>();
      // json['effect_changes'].forEach((v) { effectChanges.add(new String.fromJson(v)); });//corrigir
      json['effect_changes'].forEach((v) {
        effectChanges.add(v.toString());
      });
    }
    if (json['effect_entries'] != null) {
      effectEntries = new List<EffectEntries>();
      json['effect_entries'].forEach((v) {
        effectEntries.add(new EffectEntries.fromJson(v));
      });
    }
    flavorTextEntries = json['flavor_text_entries'] != null
        ? new FlavorTextEntries.fromJson(json['flavor_text_entries'])
        : null;
    id = json['id'];
    if (json['machines'] != null) {
      machines = new List<String>();
      // json['machines'].forEach((v) { machines.add(new String.fromJson(v)); });//corrigir
      json['machines'].forEach((v) {
        machines.add(v.toString());
      }); //corrigir
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    name = json['name'];
    if (json['past_values'] != null) {
      pastValues = new List<PastValues>();
      json['past_values'].forEach((v) {
        pastValues.add(new PastValues.fromJson(v));
      });
    }
    power = json['power'];
    pp = json['pp'];
    priority = json['priority'];
    if (json['stat_changes'] != null) {
      statChanges = new List<String>();
      // json['stat_changes'].forEach((v) { statChanges.add(new String.fromJson(v)); });//corrigir
      json['stat_changes'].forEach((v) {
        statChanges.add(v.toString());
      }); //corrigir
    }
    target = json['target'] != null ? new Comum.fromJson(json['target']) : null;
    type = json['type'] != null ? new Comum.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    if (this.contestCombos != null) {
      data['contest_combos'] = this.contestCombos.toJson();
    }
    if (this.contestEffect != null) {
      data['contest_effect'] = this.contestEffect.toJson();
    }
    if (this.contestType != null) {
      data['contest_type'] = this.contestType.toJson();
    }
    if (this.damageClass != null) {
      data['damage_class'] = this.damageClass.toJson();
    }
    data['effect_chance'] = this.effectChance;
    if (this.effectChanges != null) {
      // data['effect_changes'] = this.effectChanges.map((v) => v.toJson()).toList();//corrigir
      data['effect_changes'] =
          this.effectChanges.map((v) => v.toString()).toList(); //corrigir
    }
    if (this.effectEntries != null) {
      data['effect_entries'] =
          this.effectEntries.map((v) => v.toJson()).toList();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] = this.flavorTextEntries.toJson();
    }
    data['id'] = this.id;
    if (this.machines != null) {
      // data['machines'] = this.machines.map((v) => v.toJson()).toList();//corrigir
      data['machines'] = this.machines.map((v) => v.toString()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['name'] = this.name;
    if (this.pastValues != null) {
      data['past_values'] = this.pastValues.map((v) => v.toJson()).toList();
    }
    data['power'] = this.power;
    data['pp'] = this.pp;
    data['priority'] = this.priority;
    if (this.statChanges != null) {
      // data['stat_changes'] = this.statChanges.map((v) => v.toJson()).toList();//corrigir
      data['stat_changes'] = this.statChanges.map((v) => v.toString()).toList();
    }
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class ContestCombos {
  Normal normalCombo;
  Super superCombo;

  ContestCombos({this.normalCombo, this.superCombo});

  ContestCombos.fromJson(Map<String, dynamic> json) {
    normalCombo =
        json['normal'] != null ? new Normal.fromJson(json['normal']) : null;
    superCombo =
        json['super'] != null ? new Super.fromJson(json['super']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.normalCombo != null) {
      data['normal'] = this.normalCombo.toJson();
    }
    if (this.superCombo != null) {
      data['super'] = this.superCombo.toJson();
    }
    return data;
  }
}

class Normal {
  List<Comum> useAfter;
  List<Comum> useBefore;

  Normal({this.useAfter, this.useBefore});

  Normal.fromJson(Map<String, dynamic> json) {
    if (json['use_after'] != null) {
      useAfter = new List<Comum>();
      json['use_after'].forEach((v) {
        useAfter.add(new Comum.fromJson(v));
      });
    }
    if (json['use_before'] != null) {
      useBefore = List();
      json['use_before'].forEach((v) {
        useBefore.add(new Comum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.useAfter != null) {
      data['use_after'] = this.useAfter.map((v) => v.toJson()).toList();
    }
    data['use_before'] = this.useBefore;
    return data;
  }
}

class Super {
  List<Comum> useAfter;
  List<Comum> useBefore;

  Super({this.useAfter, this.useBefore});

  Super.fromJson(Map<String, dynamic> json) {
    if (json['use_after'] != null) {
      useAfter = List();
      json['use_after'].forEach((u) {
        useAfter.add(Comum.fromJson(u));
      });
    }
    if (json['use_before'] != null) {
      useBefore = List();
      json['use_before'].forEach((u) {
        useBefore.add(Comum.fromJson(u));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['use_after'] = this.useAfter;
    data['use_before'] = this.useBefore;
    return data;
  }
}

class ContestEffect {
  int appeal;
  List<EffectEntries> effectEntries;
  List<FlavorTextEntries> flavorTextEntries;
  int id;
  int jam;

  ContestEffect(
      {this.appeal,
      this.effectEntries,
      this.flavorTextEntries,
      this.id,
      this.jam});

  ContestEffect.fromJson(Map<String, dynamic> json) {
    appeal = json['appeal'];
    if (json['effect_entries'] != null) {
      effectEntries = new List<EffectEntries>();
      json['effect_entries'].forEach((v) {
        effectEntries.add(new EffectEntries.fromJson(v));
      });
    }
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = new List<FlavorTextEntries>();
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries.add(new FlavorTextEntries.fromJson(v));
      });
    }
    id = json['id'];
    jam = json['jam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appeal'] = this.appeal;
    if (this.effectEntries != null) {
      data['effect_entries'] =
          this.effectEntries.map((v) => v.toJson()).toList();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] =
          this.flavorTextEntries.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['jam'] = this.jam;
    return data;
  }
}

class FlavorTextEntries {
  String flavorText;
  Comum language;

  FlavorTextEntries({this.flavorText, this.language});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
    language =
        json['language'] != null ? new Comum.fromJson(json['language']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class EffectEntries {
  String effect;
  Comum language;
  String shortEffect;

  EffectEntries({this.effect, this.language, this.shortEffect});

  EffectEntries.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    language =
        json['language'] != null ? new Comum.fromJson(json['language']) : null;
    shortEffect = json['short_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effect'] = this.effect;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['short_effect'] = this.shortEffect;
    return data;
  }
}

class Meta {
  Comum ailment;
  int ailmentChance;
  Comum category;
  int critRate;
  int drain;
  int flinchChance;
  int healing;
  int maxHits;
  int maxTurns;
  int minHits;
  int minTurns;
  int statChance;

  Meta(
      {this.ailment,
      this.ailmentChance,
      this.category,
      this.critRate,
      this.drain,
      this.flinchChance,
      this.healing,
      this.maxHits,
      this.maxTurns,
      this.minHits,
      this.minTurns,
      this.statChance});

  Meta.fromJson(Map<String, dynamic> json) {
    ailment =
        json['ailment'] != null ? new Comum.fromJson(json['ailment']) : null;
    ailmentChance = json['ailment_chance'];
    category =
        json['category'] != null ? new Comum.fromJson(json['category']) : null;
    critRate = json['crit_rate'];
    drain = json['drain'];
    flinchChance = json['flinch_chance'];
    healing = json['healing'];
    maxHits = json['max_hits'];
    maxTurns = json['max_turns'];
    minHits = json['min_hits'];
    minTurns = json['min_turns'];
    statChance = json['stat_chance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ailment != null) {
      data['ailment'] = this.ailment.toJson();
    }
    data['ailment_chance'] = this.ailmentChance;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['crit_rate'] = this.critRate;
    data['drain'] = this.drain;
    data['flinch_chance'] = this.flinchChance;
    data['healing'] = this.healing;
    data['max_hits'] = this.maxHits;
    data['max_turns'] = this.maxTurns;
    data['min_hits'] = this.minHits;
    data['min_turns'] = this.minTurns;
    data['stat_chance'] = this.statChance;
    return data;
  }
}

class PastValues {
  int accuracy;
  int effectChance;
  List<String> effectEntries;
  int power;
  int pp;
  Comum type;
  Comum versionGroup;

  PastValues(
      {this.accuracy,
      this.effectChance,
      this.effectEntries,
      this.power,
      this.pp,
      this.type,
      this.versionGroup});

  PastValues.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    effectChance = json['effect_chance'];
    if (json['effect_entries'] != null) {
      effectEntries = new List<String>();
      // json['effect_entries'].forEach((v) { effectEntries.add(new String.fromJson(v)); });//corrgir
      json['effect_entries'].forEach((v) {
        effectEntries.add(v.toString());
      });
    }
    power = json['power'];
    pp = json['pp'];
    type = json['type'] != null ? new Comum.fromJson(json['type']) : null;
    versionGroup = json['version_group'] != null
        ? new Comum.fromJson(json['version_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['effect_chance'] = this.effectChance;
    if (this.effectEntries != null) {
      data['effect_entries'] =
          // this.effectEntries.map((v) => v.toJson()).toList();//corrigir
          this.effectEntries.map((v) => v.toString()).toList();
    }
    data['power'] = this.power;
    data['pp'] = this.pp;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.versionGroup != null) {
      data['version_group'] = this.versionGroup.toJson();
    }
    return data;
  }
}
