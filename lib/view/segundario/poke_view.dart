import 'package:flutter/material.dart';
import 'package:poke_magic/beans/favorito.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/view/detalhes/poke_detalhes.dart';
import 'package:poke_magic/view/principal/favorites_principal.dart';
import 'package:poke_magic/view/segundario/poke_evolucao.dart';
import 'package:poke_magic/view/segundario/poke_more.dart';
import 'package:poke_magic/view/segundario/poke_movimentos.dart';
import 'package:poke_magic/util/propaganda.dart';

class PokeView extends StatefulWidget {
  final Pokemon pokemon;
  FavoritesPrincipalState favoritesPrincipal;

  PokeView(this.pokemon, {this.favoritesPrincipal});

  @override
  _PokeViewState createState() =>
      _PokeViewState(pokemon, favoritesPrincipal: favoritesPrincipal);
}

class _PokeViewState extends State<PokeView> {
  Widget corrente;
  PokeDetalhes pokeDetalhes;
  PokeMove pokeMove;
  PokeEvolucao pokeEvolucao;
  PokeMore pokeMore;

  final Pokemon pokemon;
  Evolutions get evolutions => Evolutions();
  Moves get movimentos => Moves();
  String titulo;
  int indexCorrente;
  IconData icondata;
  Favorito favorito;
  bool isFavorite;
  FavoritesPrincipalState favoritesPrincipal;

  _PokeViewState(this.pokemon, {this.favoritesPrincipal}) {
    pokeDetalhes = PokeDetalhes(pokemon);
    corrente = pokeDetalhes;
    indexCorrente = 0;
    titulo = pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase());
    icondata = Icons.star_border;
    isFavorite = false;
    carregarFavorito();
  }

  carregarFavorito() async {
    favorito = await Favorito.getPorNome(pokemon.name);
    setState(() {
      if (favorito == null) {
        isFavorite = false;
        icondata = Icons.star_border;
      } else {
        isFavorite = true;
        icondata = Icons.star;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(titulo),
        backgroundColor: Colors.cyan,
        actions: [
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        favorito = Favorito();
                        favorito.nome = pokemon.name;
                        favorito.save();
                        icondata = Icons.star;
                        if (favoritesPrincipal != null)
                          favoritesPrincipal.add(favorito);
                      } else {
                        favorito.remove();
                        icondata = Icons.star_border;
                        if (favoritesPrincipal != null)
                          favoritesPrincipal.remove(favorito);
                        favorito = null;
                      }
                    });
                  },
                  icon: Icon(icondata, color: Colors.white),
                  label: Text(""))),
        ],
      ),
      body: corrente,
      bottomNavigationBar: BottomNavigationBar(
        onTap: mudar,
        currentIndex: indexCorrente,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text("Detail"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            title: Text("Moves"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.device_hub),
            title: Text("Evolution"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text("More"),
          ),
        ],
      ),
    );
  }

  void mudar(int i) {
    setState(() {
      Propaganda.popUp();
      indexCorrente = i;
      switch (i) {
        case 0:
          corrente = pokeDetalhes;
          break;
        case 1:
          if (pokeMove == null) pokeMove = PokeMove(pokemon);
          corrente = pokeMove;
          break;
        case 2:
          if (pokeEvolucao == null) pokeEvolucao = PokeEvolucao(pokemon);
          corrente = pokeEvolucao;
          break;
        case 3:
          if (pokeMore == null) pokeMore = PokeMore(pokemon);
          corrente = pokeMore;
          break;
        default:
      }
    });
  }
}
