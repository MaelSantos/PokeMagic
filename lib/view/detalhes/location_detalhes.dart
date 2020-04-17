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

  LocationDetalhes(this.location);

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
                        children: location.pokemonEncounters
                            .map(
                              (e) => gerarContainer(
                                  child: FittedBox(
                                      child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(children: [
                                    Text("Method:"),
                                    Column(
                                        children: e
                                            .versionDetails.encounterDetails
                                            .map((e) =>
                                                PokeButton("${e.method.name} "))
                                            .toList()),
                                  ]),
                                  VerticalDivider(),
                                  Column(children: [
                                    Text("Chance:"),
                                    PokeButton(
                                      "${e.versionDetails.maxChance}%",
                                      cor: e.versionDetails.maxChance >= 50
                                          ? Colors.green
                                          : e.versionDetails.maxChance > 35 &&
                                                  e.versionDetails.maxChance <
                                                      50
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                  ]),
                                  pokeCard(e.pokemon.name, context),
                                ],
                              ))),
                            )
                            .toList())
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget pokeCard(String nome, BuildContext context) {
    try {
      Pokemon p = Pokedex().toFormPokemon(nome);

      return PokeCard(p, sombras: true, onSelecionar: () {
        Propaganda.popUp();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PokeView(p)));
      });
    } catch (e) {
      return Container(
        child: Text(nome),
      );
    }
  }
}
