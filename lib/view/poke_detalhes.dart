import 'package:flutter/material.dart';
import 'package:poke_magic/pokemon.dart';

class PokemonDetalhes extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetalhes(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(pokemon.name),
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
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50,),
                  Text(pokemon.name),
                  Text("Altura ${pokemon.height}"),
                  Text("Largura ${pokemon.weight}"),
                  Text("Tipos"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                              backgroundColor: Colors.amber,
                              label: Text(t),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Fraquezas"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(t),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Evoluções"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution != null?
                    pokemon.nextEvolution
                        .map((t) => FilterChip(
                              label: Text(t.name),
                              backgroundColor: Colors.green,
                              onSelected: (b) {},
                            ))
                        .toList():
                    pokemon.prevEvolution
                        .map((t) => FilterChip(
                              label: Text(t.name),
                              backgroundColor: Colors.green,
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.name,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(pokemon.img))),
              ),
            ),
          ),
        ],
      );
}
