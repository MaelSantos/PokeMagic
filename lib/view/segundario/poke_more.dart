import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/forms.dart' as forma;
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class PokeMore extends StatelessWidget {
  final Pokemon pokemon;
  Weaknesses get weaknesses => Weaknesses();
  forma.Forms forms = forma.Forms();
  List<forma.Form> formas;
  Weakness type;

  PokeMore(this.pokemon) {
    type = weaknesses.toPokeWeakness(pokemon);

    formas = forms.forms
        .where((f) => f.pokemon.name.contains(pokemon.name.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text(type.name.toUpperCase()),
            gerarContainer(
                child: Column(
              children: [
                Text("Weakness"),
                Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    children: type.types
                        .where((t) => t.damage > 1)
                        .map((t) => FittedBox(
                            fit: BoxFit.contain,
                            child: PokeButton(t.name + " X${t.damage.toInt()}",
                                cor: formatColorExist(t.name))))
                        .toList()),
                Divider(thickness: 2),
                Text("Resistant or Imunne"),
                Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    children: type.types
                        .where((t) => t.damage < 1)
                        .map((t) => FittedBox(
                            fit: BoxFit.contain,
                            child: PokeButton(
                                t.name +
                                    " X${t.damage == 0.5 ? '1/2' : (t.damage == 0 ? '0' : '1/4')}",
                                cor: formatColorExist(t.name))))
                        .toList()),
                Divider(thickness: 2),
                Text("Normal Damage"),
                Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    children: type.types
                        .where((t) => t.damage == 1)
                        .map((t) => FittedBox(
                            fit: BoxFit.contain,
                            child: PokeButton(t.name + " X${t.damage.toInt()}",
                                cor: formatColorExist(t.name))))
                        .toList()),
              ],
            )),
            Text("EV provided"),
            gerarContainer(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon.stats
                          .where((p) => p.ev > 0)
                          .map((e) => PokeButton("+${e.ev} ${e.stat}"))
                          .toList())),
            ),
            Text("Sprites"),
            gerarContainer(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Normal"),
                    imagemSprite(formatNormal(pokemon.number), context)
                  ],
                ),
                Column(
                  children: [
                    Text("Shiny"),
                    imagemSprite(formatShiny(pokemon.number), context)
                  ],
                )
              ],
            )),
            Text("Forms"),
            gerarContainer(
                child: Wrap(
              spacing: 30,
              children: formas.isNotEmpty
                  ? formas
                      .map((f) => Column(children: [
                            Text(
                                "${f.formName[0].toUpperCase()}${f.formName.substring(1)}"),
                            imagemSprite(
                                f.sprites.frontDefault != null
                                    ? f.sprites.frontDefault
                                    : "",
                                context)
                          ]))
                      .toList()
                  : [Text("No Forms")],
            ))
          ])),
    );
  }

  Widget imagemSprite(String url, BuildContext context) {
    return FittedBox(
        child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width / 3,
            child: CachedNetworkImage(
              imageUrl: url,
              progressIndicatorBuilder: (context, url, download) =>
                  CircularProgressIndicator(value: download.progress),
              errorWidget: (context, url, error) =>
                  Center(child: Text("No Sprite")),
              fit: BoxFit.contain,
            )));
  }
}
