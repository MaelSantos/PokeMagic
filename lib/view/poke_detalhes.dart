import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokeDetalhes extends StatelessWidget {
  final Pokemon pokemon;
  String titulo;
  PokeDetalhes(this.pokemon) {
    titulo = pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.all(4),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(5),
            child: ListView(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: formatID(pokemon.id),
                      child: Container(
                        width: 200,
                        height: 175,
                        child: CachedNetworkImage(
                          imageUrl: formatID(pokemon.id),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(titulo, style: TextStyle(fontSize: 23)),
                    Text("Height: ${pokemon.height}"),
                    Text("Weight: ${pokemon.weight}"),
                    Text("Types", style: TextStyle(fontSize: 16)),
                  ],
                ),
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
                Text("Abilities",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
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
                Text("Statistics",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                Column(
                    children: pokemon.stats.reversed
                        .map((s) => Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.stat.name,
                                    style: TextStyle(color: Colors.white)),
                                Text(s.baseStat.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )))
                        .toList()),
              ],
            ),
          )),
    );
  }
}
