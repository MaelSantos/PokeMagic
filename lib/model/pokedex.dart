import 'package:poke_magic/model/pokemon.dart';

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
    return pokemons.firstWhere((p) => poke == p.name);
  }
}
