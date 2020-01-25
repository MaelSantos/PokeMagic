import 'package:poke_magic/model/pokemon.dart';

class Pokedex {
  static final int pokeTotal = 807;

  List<Pokemon> pokemons;

  Pokedex({this.pokemons});

  Pokedex.fromJson(Map<String, dynamic> json) {
    pokemons = List();
    for (int i = 1; i <= pokeTotal; i++)
      pokemons.add(json['$i'] != null ? Pokemon.fromJson(json['$i']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemons != null) {
      for (int i = 1; i <= pokemons.length; i++)
        data['$i'] = this.pokemons[i].toJson();
    }
    return data;
  }
}
