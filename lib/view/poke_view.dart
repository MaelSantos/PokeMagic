import 'package:flutter/material.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/model/pokemon.dart';
import 'package:poke_magic/view/poke_detalhes.dart';
import 'package:poke_magic/view/poke_evolucao.dart';
import 'package:poke_magic/view/poke_more.dart';
import 'package:poke_magic/view/poke_movimentos.dart';
// import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokeView extends StatefulWidget {
  final Pokemon pokemon;
  final Evolutions evolutions;
  final Moves movimentos;

  PokeView(this.pokemon, this.evolutions, this.movimentos);

  @override
  _PokeViewState createState() => _PokeViewState(pokemon, evolutions, movimentos);
}

class _PokeViewState extends State<PokeView> {
  Widget corrente;
  PokeDetalhes pokeDetalhes;
  PokeMove pokeMove;
  PokeEvolucao pokeEvolucao;
  PokeMore pokeMore;

  final Pokemon pokemon;
  final Evolutions evolutions;
  final Moves movimentos;
  String titulo;
  int indexCorrente;

  _PokeViewState(this.pokemon, this.evolutions, this.movimentos) {
    pokeDetalhes = PokeDetalhes(pokemon);
    pokeMove = PokeMove(pokemon, movimentos);
    pokeEvolucao = PokeEvolucao(pokemon, evolutions, movimentos);
    pokeMore = PokeMore();
    corrente = pokeDetalhes;
    indexCorrente = 0;
    titulo = pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(titulo),
          backgroundColor: Colors.cyan),
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
      indexCorrente = i;
      switch (i) {
        case 0:
          corrente = pokeDetalhes;
          break;
        case 1:
          corrente = pokeMove;
          break;
        case 2:
          corrente = pokeEvolucao;
          break;
        case 3:
          corrente = pokeMore;
          break;
        default:
      }
    });
  }
}
