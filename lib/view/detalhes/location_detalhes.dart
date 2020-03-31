import 'package:flutter/material.dart';
import 'package:poke_magic/model/locations.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';

class LocationDetalhes extends StatelessWidget {
  final Location location;
  List<Pokemon> pokemons;

  LocationDetalhes(this.location) {
    pokemons = Pokedex().pokemons.where((p) {
      for (PokemonEncounters e in location.pokemonEncounters)
        if (p.name == e.pokemon.name) return true;
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(location.location.name.toUpperCase()),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(location.location.name.toUpperCase()),
                Divider(thickness: 2),
                Column(
                  children: [
                    Text("Pokémon's"),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          location.pokemonEncounters.length,
                          (i) => gerarContainer(
                              child: FittedBox(
                                  child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Text("Method:"),
                                Column(
                                    children: location.pokemonEncounters[i]
                                        .versionDetails.encounterDetails
                                        .map((e) =>
                                            PokeButton("${e.method.name} "))
                                        .toList()),
                              ]),
                              VerticalDivider(),
                              Column(children: [
                                Text("Chance:"),
                                PokeButton(
                                  "${location.pokemonEncounters[i].versionDetails.maxChance}%",
                                  cor: location.pokemonEncounters[i]
                                              .versionDetails.maxChance >=
                                          50
                                      ? Colors.green
                                      : location
                                                      .pokemonEncounters[i]
                                                      .versionDetails
                                                      .maxChance >
                                                  35 &&
                                              location
                                                      .pokemonEncounters[i]
                                                      .versionDetails
                                                      .maxChance <
                                                  50
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                              ]),
                              PokeCard(pokemons[i], sombras: true,
                                  onSelecionar: () {
                                Propaganda.popUp();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PokeView(pokemons[i])));
                              })
                            ],
                          ))),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
