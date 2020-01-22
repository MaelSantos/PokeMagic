import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:pokeapi/model/evolution/evolution-chain.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokemonDetalhes extends StatelessWidget {
  final Pokemon pokemon;
  EvolutionChain evolucao;
  String titulo;
  PokemonDetalhes(this.pokemon) {
    titulo = pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase());
    print(pokemon.stats);
    carregarDados();
  }

  void carregarDados() async {
    evolucao = await PokeAPI.getObject<EvolutionChain>(pokemon.id);
    // print(evolucao.chain.evolvesTo[0].evolvesTo);
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
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 220,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.16,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                // padding: EdgeInsets.only(bottom: 5, top: 5),
                margin: EdgeInsets.only(bottom: 5, top: 80),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   height: 70,
                  // ),
                  Text(titulo, style: TextStyle(fontSize: 23)),
                  Text("Altura: ${pokemon.height}"),
                  Text("Largura: ${pokemon.weight}"),
                  Text("Tipos"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.types.reversed
                        .map((t) => FilterChip(
                              backgroundColor: formatColorExist(t.type.name),
                              label: Text(t.type.name,
                                  style: TextStyle(color: Colors.white)),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Habilidades"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.abilities.reversed
                        .map((t) => FilterChip(
                              backgroundColor: Colors.cyan,
                              label: Text(t.ability.name,
                                  style: TextStyle(color: Colors.white)),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Estatisticas"),
                  Expanded(
                    child: Column(
                        // crossAxisCount: 4,
                        children: pokemon.stats.reversed
                            .map((s) => Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                    // width: s.baseStat.toDouble(),
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(s.stat.name,
                                        style: TextStyle(color: Colors.white)),
                                    Text(s.baseStat.toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ))))
                            .toList()),
                  ),
                  // Text("Movimentos"),
                  // Expanded(
                  //   child: ListView(
                  //       children: pokemon.moves
                  //           .map((t) => FilterChip(
                  //                 backgroundColor: Colors.red,
                  //                 label: Text(t.move.name),
                  //                 onSelected: (b) {},
                  //               ))
                  //           .toList()),
                  // ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pokemon.moves
                  //       .map((t) => FilterChip(
                  //             backgroundColor: Colors.red,
                  //             label: Text(t.move.name),
                  //             onSelected: (b) {},
                  //           ))
                  //       .toList(),
                  // ),
                  // Text("Evoluções"),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: evolucoes(pokemon),
                  // ),
                ],
              ),
              )
              
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: formatID(pokemon.id),
                child: Container(
                  width: 200,
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: formatID(pokemon.id),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(days: 30),
                    fadeOutDuration: Duration(days: 30),
                  ),
                ),
              )),
        ],
      );

  // List<Widget> evolucoes(Pokemon pokemon) {
  //   List<Widget> evo = List();

  //   if (pokemon.nextEvolution != null)
  //     evo.addAll(pokemon.nextEvolution
  //         .map((t) => FilterChip(
  //               label: Text(t.name),
  //               backgroundColor: Colors.green,
  //               onSelected: (b) {},
  //             ))
  //         .toList());

  //   if (pokemon.prevEvolution != null)
  //     evo.addAll(pokemon.prevEvolution
  //         .map((t) => FilterChip(
  //               label: Text(t.name),
  //               backgroundColor: Colors.green,
  //               onSelected: (b) {},
  //             ))
  //         .toList());
  //   if (evo.isEmpty) evo.add(Text("-"));

  //   return evo;
  // }
}
