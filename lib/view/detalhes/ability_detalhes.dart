import 'package:flutter/material.dart';
import 'package:poke_magic/model/abilitys.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/poke_view.dart';

class AbilityDetalhes extends StatelessWidget {
  final Ability ability;

  const AbilityDetalhes(this.ability);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(ability.name),
            backgroundColor: Colors.cyan),
        body: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gerarContainer("",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name: " + ability.name),
                        Text(
                            "In Series: ${ability.isMainSeries ? 'yes' : 'no'}"),
                        Text("Introduced in : ${ability.generation.name}"),
                      ],
                    )),
                gerarContainer(
                    "Descrition: ${ability.flavorTextEntries.flavorText}"),
                gerarContainer("Effect: ${ability.effectEntries.shortEffect}"),
                // ability.effectChanges != null
                //     ? gerarContainer(
                //         "Effect: ${ability.effectEntries.shortEffect}")
                //     : Container(),
                gerarContainer(
                    "Details Effect: ${ability.effectEntries.effect}"),
                Divider(thickness: 2),
                Column(
                  children: [
                    Text("Pokémon's with this ability"),
                    Column(
                      children: ability.pokemon
                          .map((p) => PokeCard(
                              Pokedex().toPokemon(p.pokemon.name),
                              axis: Axis.vertical,onSelecionar: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PokeView(Pokedex().toPokemon(p.pokemon.name))));
                    }))
                          .toList(),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget gerarContainer(String conteudo,
      {double tamanho = 60, Color cor = Colors.black, Widget child}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: child == null
            ? Text(conteudo, style: TextStyle(color: cor))
            : child);
  }
}
