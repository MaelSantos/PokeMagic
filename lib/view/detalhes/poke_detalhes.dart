import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/abilitys.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/types.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/bar_custom.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/detalhes/ability_detalhes.dart';
import 'package:poke_magic/view/detalhes/type_detalhes.dart';

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
                      tag: formatID(pokemon.number),
                      child: Container(
                        width: 200,
                        height: 175,
                        child: CachedNetworkImage(
                          imageUrl: formatID(pokemon.number),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          // fit: BoxFit.contain,
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
                      .map((t) => PokeButton(t.type.name,
                              cor: formatColorExist(t.type.name),
                              onSelecionado: (b) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TypeDetalhes(
                                        Types().toType(t.type.name))));
                          }))
                      .toList(),
                ),
                Text("Abilities",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.abilities.reversed
                            .map((t) => PokeButton(t.ability.name,
                                    isEscondido: t.isHidden,
                                    onSelecionado: (b) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AbilityDetalhes(
                                              Abilitys()
                                                  .toAbility(t.ability.name))));
                                }))
                            .toList(),
                      )),
                ),
                Text("Statistics",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                SingleChildScrollView(
                    child: Container(
                  height: 190,
                  child: BarCustom(BarCustom.createSampleData(
                      pokemon.stats.reversed.toList())),
                )),
              ],
            ),
          )),
    );
  }
}
