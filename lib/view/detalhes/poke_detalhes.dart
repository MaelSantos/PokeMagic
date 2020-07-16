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
                                pokemon.number != "#555_f3" &&
                                pokemon.number != "#670_f2" &&
                                pokemon.number != "#745_f3"
                            ? imagemNet(context)
                            : imagemAsset(context))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(titulo, style: TextStyle(fontSize: 23)),
                    Text(
                        "Height: ${(pokemon.id > 807 ? pokemon.height * 10 : pokemon.height * 0.1).toStringAsPrecision(2)} m"),
                    Text(
                        "Weight: ${pokemon.weight == 0 ? '?' : (pokemon.id > 807 ? pokemon.weight * 10 : pokemon.weight * 0.1).toStringAsPrecision(2)} kg"),
                    Text("Types", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.types
                      .map((t) => PokeButton(t, cor: formatColorExist(t),
                              onSelecionado: (b) {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TypeDetalhes(
                                        Types().toType(t.toLowerCase()))));
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
                        children: pokemon.abilities
                            .map((t) =>
                                PokeButton(t.ability, isEscondido: t.isHidden,
                                    onSelecionado: (b) {
                                  Propaganda.popUp();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AbilityDetalhes(
                                              Abilitys().toAbility(
                                                  t.ability.toLowerCase()),
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
                  height: 180,
                  child: BarCustom(
                      statsList: [BarCustom.createSampleData(pokemon.stats)]),
                ),
                Container(
                  height: 60,
                  child: BarCustom(
                      statsList: [BarCustom.createTotalData(pokemon.stats)]),
                ),
              ],
            ),
          )),
    );
  }

  Widget imagemNet(BuildContext context) {
    return Container(
      width: 200,
      height: 180,
      child: CachedNetworkImage(
        imageUrl: formatID(pokemon.number),
        progressIndicatorBuilder: (context, url, download) =>
            CircularProgressIndicator(value: download.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fitWidth,
        // fit: BoxFit.cover,
      ),
    );
  }

  Widget imagemAsset(BuildContext context) {
    Widget ret;
    ret = Container(
        width: 200,
        height: 180,
        child: Image.asset("assets/temp/${pokemon.number}.png"));
    return ret;
  }
}
