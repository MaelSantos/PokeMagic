import 'package:flutter/material.dart';
import 'package:poke_magic/model/abilitys.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/principal/favorites_principal.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';
import 'package:poke_magic/util/propaganda.dart';

class AbilityDetalhes extends StatelessWidget {
  final Ability ability;
  final FavoritesPrincipalState favoritesPrincipal;
  const AbilityDetalhes(this.ability, {this.favoritesPrincipal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(ability.name.toUpperCase())),
        body: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gerarContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: " + ability.name.toUpperCase()),
                    Text("In Series: ${ability.isMainSeries ? 'yes' : 'no'}"),
                    Text("Introduced in : ${ability.generation.name}"),
                  ],
                )),
                gerarContainer(
                    child: Text(
                        "Descrition: ${ability.flavorTextEntries.flavorText}")),
                gerarContainer(
                    child:
                        Text("Effect: ${ability.effectEntries.shortEffect}")),
                gerarContainer(
                    child: Text(
                        "Details Effect: ${ability.effectEntries.effect}")),
                Divider(thickness: 2),
                Column(
                  children: [
                    Text("Pokémon's with this ability"),
                    Column(children: pokeCard(context))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> pokeCard(BuildContext context) {
    List<Widget> pokecards = List();
    List<String> nomes = List();
    for (AbilityPokemon p in ability.pokemon) {
      Pokemon pokemon;

      try {
        pokemon = Pokedex().pokemons.firstWhere((a) =>
            (p.pokemon.name == a.name.toLowerCase() ));//|| (p.pokemon.name == a.forms[0].name)
      } catch (e) {
        pokemon = null;
      }

      if (pokemon != null && !nomes.contains(pokemon.name.toLowerCase()))
        nomes.add(pokemon.name);
      else if (pokemon != null && nomes.contains(pokemon.name.toLowerCase())) pokemon = null;
      if (pokemon != null) {
        pokecards.add(PokeCard(pokemon, axis: Axis.vertical, onSelecionar: () {
          Propaganda.popUp();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PokeView(pokemon,
                      favoritesPrincipal: favoritesPrincipal)));
        }));
      }
    }
    return pokecards;
  }
}
