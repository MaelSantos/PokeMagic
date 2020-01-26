import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/evolution.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/pokemon.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/poke_view.dart';
// import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokeEvolucao extends StatelessWidget {
  final Pokemon pokemon;
  final Evolutions evolutions;
  Evolution evolution;

  PokeEvolucao(this.pokemon, this.evolutions) {
    evolution = evolutions.evolution.firstWhere(escolherEvolucao);
    if (evolution == null) evolution = evolutions.evolution[0];
  }

  bool escolherEvolucao(Evolution e) {
    bool ret = false;
    if (e.chain.species.name == pokemon.name)
      ret = true;
    else if (e.chain.evolvesTo.isNotEmpty) {
      for (EvolvesTo a in e.chain.evolvesTo) {
        a.species.name == pokemon.name ? ret = true : ret = false;
        if (ret) break;

        if (a.evolvesToTo.isNotEmpty)
          for (EvolvesToTo b in a.evolvesToTo) {
            b.species.name == pokemon.name ? ret = true : ret = false;
            if (ret) break;
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
                  ? pokeLink(evolution.chain.evolvesTo)
                  : Container(),
              evolution.chain.evolvesTo.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                          children: evolution.chain.evolvesTo
                              .map((f) => pokeCard(f.species.name, context))
                              .toList()))
                  : Container(),
              evolution.chain.evolvesTo.isNotEmpty &&
                      evolution.chain.evolvesTo[0].evolvesToTo.isNotEmpty
                  ? pokeLink(evolution.chain.evolvesTo[0].evolvesToTo)
                  : Container(),
              evolution.chain.evolvesTo.isNotEmpty &&
                      evolution.chain.evolvesTo[0].evolvesToTo.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: evolution.chain.evolvesTo[0].evolvesToTo
                          .map((f) => pokeCard(f.species.name, context))
                          .toList())
                  : Container(),
            ],
          ),
        )));
  }

  Widget pokeCard(String nome, BuildContext context) {
    Pokemon poke = Pokedex().toPokemon(nome);
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 160,
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokeView(poke, evolutions)));
              },
              child: Card(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                      imageUrl: formatID(poke.number),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain),
                  Text("${poke.number} - $nome", textAlign: TextAlign.center)
                ],
              )),
            )));
  }

  Widget pokeLink(List list) {
    List<Widget> colunas = List();
    String gatilho = "";
    String motivo = "";

    // evolution.chain.evolvesTo[0].evolutionDetails[0].knownMoveType;
    for (dynamic e in list) {
      gatilho = e.evolutionDetails[0].trigger.name;

      switch (gatilho) {
        case "level-up":
          motivo = e.evolutionDetails[0].minLevel.toString();
          print(motivo);
          if (motivo == "null" && e.evolutionDetails[0].minHappiness != null) {
            gatilho = "happiness";
            motivo = e.evolutionDetails[0].timeOfDay;
          }
          if (e.evolutionDetails[0].minAffection != null)
            motivo = e.evolutionDetails[0].minAffection.toString();
          if (motivo == "null" && e.evolutionDetails[0].location != null)
            motivo = e.evolutionDetails[0].location.name;
          if (motivo == "null" && e.evolutionDetails[0].knownMoveType != "null")
          {
            gatilho += "move";
            motivo = e.evolutionDetails[0].knownMoveType.toString();
          }

          break;
        case "use-item":
          motivo = e.evolutionDetails[0].item.name;
          break;
        default:
      }
      colunas.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("---->"), Text("$gatilho"), Text("$motivo")]));
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: colunas);
  }
}
