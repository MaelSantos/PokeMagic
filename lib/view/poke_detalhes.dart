import 'package:flutter/material.dart';
import 'package:poke_magic/util.dart/format.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonDetalhes extends StatelessWidget {
  final Pokemon pokemon;
  String titulo;
  PokemonDetalhes(this.pokemon) {
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
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 1.5,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.16,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(titulo),
                  Text("Altura: ${pokemon.height}"),
                  Text("Largura: ${pokemon.weight}"),
                  Text("Tipos"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.types
                        .map((t) => FilterChip(
                              backgroundColor: Colors.amber,
                              label: Text(t.type.name),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  // Text("Movimentos"),
                  // Row(
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
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: formatID(pokemon.id),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(formatID(pokemon.id)))),
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
