import 'package:poke_magic/model/comum.dart';

class Forms {
  List<Form> forms;

  static final Forms _instance = Forms.internal();
  factory Forms() => _instance;
  Forms.internal();

  static Forms fromJson(Map<String, dynamic> json) {
    _instance.forms = List();
    for (int i = 10001; i <= 10316; i++)
      if (json['$i'] != null) _instance.forms.add(Form.fromJson(json['$i']));
    return _instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.forms != null) {
      for (int i = 1; i <= forms.length; i++)
        data['$i'] = this.forms[i].toJson();
    }
    return data;
  }

  Form toForm(String nome) => forms.firstWhere((m) => m.name == nome);
}

class Form {
  String formName;
  int formOrder;
  int id;
  bool isBattleOnly;
  bool isDefault;
  bool isMega;
  String name;
  int order;
  Comum pokemon;
  Sprites sprites;

  Form(
      {this.formName,
      this.formOrder,
      this.id,
      this.isBattleOnly,
      this.isDefault,
      this.isMega,
      this.name,
      this.order,
      this.pokemon,
      this.sprites});

  Form.fromJson(Map<String, dynamic> json) {
    formName = json['form_name'];
    formOrder = json['form_order'];
    id = json['id'];
    isBattleOnly = json['is_battle_only'];
    isDefault = json['is_default'];
    isMega = json['is_mega'];
    name = json['name'];
    order = json['order'];
    pokemon =
        json['pokemon'] != null ? new Comum.fromJson(json['pokemon']) : null;
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['form_name'] = this.formName;
    data['form_order'] = this.formOrder;
    data['id'] = this.id;
    data['is_battle_only'] = this.isBattleOnly;
    data['is_default'] = this.isDefault;
    data['is_mega'] = this.isMega;
    data['name'] = this.name;
    data['order'] = this.order;
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    return data;
  }
}

class Sprites {
  String backDefault;
  String backShiny;
  String frontDefault;
  String frontShiny;

  Sprites(
      {this.backDefault, this.backShiny, this.frontDefault, this.frontShiny});

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['back_default'] = this.backDefault;
    data['back_shiny'] = this.backShiny;
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}
