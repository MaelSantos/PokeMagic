import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokemon.dart';
import 'package:poke_magic/util/format.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final Function onSelecionar;

  PokeCard(this.pokemon, {this.onSelecionar});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width * 0.30,
        // height: MediaQuery.of(context).size.height * 0.26,
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSelecionar,
            child: Hero(
                tag: formatID(pokemon.number),
                child: Card(
                    elevation: 3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: CachedNetworkImage(
                            imageUrl: formatID(pokemon.number),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          )),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "${pokemon.number} - ${pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase())}",
                                    textAlign: TextAlign.center),
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //     child:
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: pokemon.types.reversed
                                      .map((t) => Container(
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.all(4),
                                            // width: 40,
                                            decoration: BoxDecoration(
                                                color: formatColorExist(
                                                    t.type.name),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                              t.type.name,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))
                                      .toList(),
                                )
                                // ),
                              ])
                        ])))));
  }
}
