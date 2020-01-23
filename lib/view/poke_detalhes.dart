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
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(4),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    Column(
                        children: pokemon.stats.reversed
                            .map((s) => Container(
                                margin:
                                    EdgeInsets.only(top: 5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(s.stat.name,
                                        style: TextStyle(color: Colors.white)),
                                    Text(s.baseStat.toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                )))
                            .toList()),

                    // Text("Evoluções"),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: evolucoes(pokemon),
                    // ),
                  ],
                ),
              )),
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
                ),
              ),
            )),
      ],
    );
  }
}
