import 'package:poke_magic/model/comum.dart';

class Itens {
  List<Item> itens;

  static final Itens _instance = Itens.internal();
  factory Itens() => _instance;
  Itens.internal();

  static Itens fromJson(Map<String, dynamic> json) {
    _instance.itens = List();
    for (int i = 1; i <= json.length; i++)
      if (json['$i'] != null) _instance.itens.add(Item.fromJson(json['$i']));
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.itens != null) {
      for (int i = 1; i <= itens.length; i++)
        data['$i'] = this.itens[i].toJson();
    }
    return data;
  }
}

class Item {
  List<Attributes> attributes;
  String babyTriggerFor;
  Attributes category;
  int cost;
  EffectEntries effectEntries;
  FlavorTextEntries flavorTextEntries;
  Comum flingEffect;
  int flingPower;
  int id;
  String name;
  Sprites sprites;

  Item(
      {this.attributes,
      this.babyTriggerFor,
      this.category,
      this.cost,
      this.effectEntries,
      this.flavorTextEntries,
      this.flingEffect,
      this.flingPower,
      this.id,
      this.name,
      this.sprites});

  Item.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    babyTriggerFor = json['baby_trigger_for'].toString(); //corrigir
    category = json['category'] != null
        ? new Attributes.fromJson(json['category'])
        : null;
    cost = json['cost'];
    effectEntries = json['effect_entries'] != null
        ? new EffectEntries.fromJson(json['effect_entries'])
        : null;
    flavorTextEntries = json['flavor_text_entries'] != null
        ? new FlavorTextEntries.fromJson(json['flavor_text_entries'])
        : null;
    flingEffect = json['fling_effect'] != null
        ? Comum.fromJson(json['fling_effect'])
        : null;
    flingPower = json['fling_power'];
    id = json['id'];
    name = json['name'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['baby_trigger_for'] = this.babyTriggerFor;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['cost'] = this.cost;
    if (this.effectEntries != null) {
      data['effect_entries'] = this.effectEntries.toJson();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] = this.flavorTextEntries.toJson();
    }
    data['fling_effect'] = this.flingEffect;
    data['fling_power'] = this.flingPower;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    return data;
  }
}

class Attributes {
  String name;
  String url;

  Attributes({this.name, this.url});

  Attributes.fromJson(Map<String, dynamic> json) {
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
  String text;

  FlavorTextEntries({this.text});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Sprites {
  String defaultt;

  Sprites({this.defaultt});

  Sprites.fromJson(Map<String, dynamic> json) {
    defaultt = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default'] = this.defaultt;
    return data;
  }
}
