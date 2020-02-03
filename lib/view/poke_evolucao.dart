import 'package:flutter/material.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/poke_view.dart';

class PokeEvolucao extends StatelessWidget {
  final Pokemon pokemon;
  Evolutions get evolutions => Evolutions();

  Evolution evolution;

  PokeEvolucao(this.pokemon) {
    print(pokemon.name);
    try {
      evolution = evolutions.evolution.firstWhere(escolherEvolucao);
    } catch (e) {
      if (evolution == null) evolution = evolutions.evolution[250];
    }
  }

  bool escolherEvolucao(Evolution e) {
    bool ret = false;

    if (e.chain.species.name == pokemon.name)
      ret = true;
    else if (e.chain.evolvesTo.isNotEmpty) {
      for (EvolvesTo a in e.chain.evolvesTo) {
        if (ret)
          break;
        else
          a.species.name == pokemon.name ? ret = true : ret = false;

        if (a.evolvesToTo.isNotEmpty)
          for (EvolvesToTo b in a.evolvesToTo) {
            if (ret)
              break;
            else
              b.species.name == pokemon.name ? ret = true : ret = false;
          }
      }
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Center(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                evolution.chain != null
                    ? pokeCard(evolution.chain.species.name, context)
                    : Container(),
              ]),
              evolution.chain.evolvesTo.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                          children: nextEvolution(
                              context, evolution.chain.evolvesTo, true)))
                  : Container(),
              evolution.chain.evolvesTo.isNotEmpty &&
                      evolution.chain.evolvesTo[0].evolvesToTo.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: nextEvolution(
                          context, evolution.chain.evolvesTo, false))
                  : Container(),
            ],
          ),
        )));
  }

  Widget pokeCard(String nome, BuildContext context) {
    Pokemon poke = Pokedex().toPokemon(nome);
    return Container(
        width: MediaQuery.of(context).size.width * 0.25,
        // height: 165,
        child: PokeCard(poke, size: 10, onSelecionar: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PokeView(poke)));
        }));
  }

  List<Widget> nextEvolution(
      BuildContext context, List<dynamic> to, bool next) {
    List<Widget> cont = List();

    for (dynamic a in to) {
      if (!next)
        for (EvolvesToTo b in a.evolvesToTo) {
          Row row = Row(
            children: [
              pokeLink(b.evolutionDetails, context),
              pokeCard(b.species.name, context)
            ],
          );
          cont.add(row);
        }
      else {
        Row row = Row(
          children: [
            pokeLink(a.evolutionDetails, context),
            pokeCard(a.species.name, context)
          ],
        );
        cont.add(row);
      }
    }

    return cont;
  }

  Widget pokeLink(List list, BuildContext context) {
    List<Widget> colunas = List();
    String gatilho = "";
    String motivo = "";

    // evolution.chain.evolvesTo[0].evolutionDetails[0].knownMoveType;

    if (list.length > 1)
      for (dynamic e in list) {
        gatilho = e.trigger.name;
        if (list[0].minLevel != null) motivo = list[0].minLevel.toString();
        if (e.location != null)
          motivo.isEmpty
              ? motivo += "location: " + e.location.name
              : motivo += " or " + e.location.name;
        if (e.minBeauty != null && e.minBeauty != 0)
          motivo = "beauty: " + e.minBeauty.toString();
      }
    else {
      gatilho = list[0].trigger.name;

      switch (gatilho) {
        case "level-up":
          if (list[0].minLevel != null) motivo = list[0].minLevel.toString();

          if (list[0].gender != null)
            motivo += "\n" + (list[0].gender == 1 ? "female ♀" : "male ♂");

          if (list[0].minHappiness != null) gatilho = "happiness";

          if (list[0].location != null)
            motivo = "location: " + list[0].location.name;

          if (list[0].knownMoveType != null)
            motivo = "move " + list[0].knownMoveType.name;

          if (list[0].knownMoveType != null && list[0].timeOfDay != null)
            motivo += "\n" + list[0].timeOfDay;

          if (list[0].heldItem != null)
            motivo = "holding: " + list[0].heldItem.name;

          if (list[0].knownMove != null)
            motivo = "move " + list[0].knownMove.name;

          if (list[0].minBeauty != null && list[0].minBeauty != 00)
            motivo = "beauty: " + list[0].minBeauty.toString();

          if (list[0].relativePhysicalStats != null) {
            if (list[0].relativePhysicalStats == 1)
              motivo += "\nattack > defense";
            if (list[0].relativePhysicalStats == -1)
              motivo += "\nattack < defense";
            if (list[0].relativePhysicalStats == 0)
              motivo += "\nattack = defense";
          }

          if (list[0].partySpecies != null)
            motivo = list[0].partySpecies.name + " in the team";

          if (list[0].timeOfDay != null && list[0].timeOfDay.isNotEmpty) {
            motivo != "null" && motivo.isNotEmpty
                ? motivo += "\n" + list[0].timeOfDay
                : motivo = list[0].timeOfDay;
          }

          break;
        case "use-item":
          motivo = list[0].item.name;
          if (list[0].gender != null)
            motivo += "\n" + (list[0].gender == 1 ? "female ♀" : "male ♂");
          break;
        case "trade":
          // gatilho = "negotiation";
          if (list[0].heldItem != null)
            motivo = "holding item: " + list[0].heldItem.name;
          break;
        default:
      }
    }

    colunas.add(Container(
        width: MediaQuery.of(context).size.width * 0.18,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("---->", textAlign: TextAlign.center),
              Text("$gatilho", textAlign: TextAlign.center),
              Text("$motivo", textAlign: TextAlign.center)
            ])));

    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: colunas);
  }
}
