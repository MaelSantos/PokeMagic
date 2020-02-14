import 'package:flutter/material.dart';
import 'package:poke_magic/beans/favorito.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';

class FavoritesPrincipal extends StatefulWidget {
  FavoritesPrincipalState _state;
  static final FavoritesPrincipal _instance = FavoritesPrincipal.internal();
  factory FavoritesPrincipal() {
    _instance._state = FavoritesPrincipalState();
    return _instance;
  }
  FavoritesPrincipal.internal();

  @override
  FavoritesPrincipalState createState() => _state;
}

class FavoritesPrincipalState extends State<FavoritesPrincipal> {
  List<Favorito> favoritos;
  List<Pokemon> pokemons;
  Pokedex pokedex;

  FavoritesPrincipalState() {
    init();
  }
  init() {
    pokemons = List();
    pokedex = Pokedex();
    carregarFavoritos();
  }

  carregarFavoritos() async {
    favoritos = await Favorito.getAll();
    pokemons = pokedex.pokemons.where((p) {
      for (Favorito _state in favoritos) if (_state.nome == p.name) return true;
      return false;
    }).toList();
    if (mounted) setState(() {});
  }

  add(Favorito favorito) {
    favoritos.add(favorito);
    pokemons.add(pokedex.toPokemon(favorito.nome));
    if (mounted) setState(() {});
  }

  remove(Favorito favorito) {
    favoritos.remove(favorito);
    pokemons.removeWhere((p) => p.name == favorito.nome);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.topLeft,
        child: favoritos == null
            ? Center(child: CircularProgressIndicator())
            : favoritos.isEmpty
                ? Center(child: Text("No Favorites"))
                : GridView.count(
                    crossAxisCount: 2,
                    children: pokemons
                        .map((p) => PokeCard(p, fitbox: true, onSelecionar: () {
                              Propaganda.popUp();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokeView(p,
                                          favoritesPrincipal: this)));
                            }))
                        .toList(),
                  ));
  }
}
