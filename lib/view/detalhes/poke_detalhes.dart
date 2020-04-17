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
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/principal/favorites_principal.dart';

class PokeDetalhes extends StatelessWidget {
  final Pokemon pokemon;
  String titulo;
  FavoritesPrincipalState favoritesPrincipal;
  PokeDetalhes(this.pokemon, {this.favoritesPrincipal}) {
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
                        child: pokemon.number != "#351_f2" &&
                                pokemon.number != "#351_f3" &&
                                pokemon.number != "#351_f4" &&
                                pokemon.number != "#555_f2" &&
                                pokemon.number != "#670_f2" &&
                                pokemon.number != "#745_f3"
                            ? imagemNet()
                            : imagemAsset())),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(titulo, style: TextStyle(fontSize: 23)),
                    Text(
                        "Height: ${(pokemon.height * 0.1).toStringAsPrecision(pokemon.height.toString().length)} m"),
                    Text(
                        "Weight: ${(pokemon.weight * 0.1).toStringAsPrecision(pokemon.weight.toString().length)} kg"),
                    Text("Types", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.types.reversed
                      .map((t) => PokeButton(t.type.name,
                              cor: formatColorExist(t.type.name),
                              onSelecionado: (b) {
                            Propaganda.popUp();
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
                                  Propaganda.popUp();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AbilityDetalhes(
                                              Abilitys()
                                                  .toAbility(t.ability.name),
                                              favoritesPrincipal:
                                                  favoritesPrincipal)));
                                }))
                            .toList(),
                      )),
                ),
                Text("Statistics",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                Container(
                  height: 190,
                  child: BarCustom(statsList: [
                    BarCustom.createSampleData(pokemon.stats.reversed.toList()),
                  ]),
                ),
                Container(
                  height: 60,
                  child: BarCustom(statsList: [
                    BarCustom.createTotalData(pokemon.stats.reversed.toList()),
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Widget imagemNet() {
    return Container(
      width: 200,
      height: 175,
      child: CachedNetworkImage(
        imageUrl: formatID(pokemon.number),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        // fit: BoxFit.contain,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget imagemAsset() {
    Widget ret;
    ret = Container(
        width: 200,
        height: 175,
        child: Image.asset("assets/temp/${pokemon.number}.png"));
    return ret;
  }
}
