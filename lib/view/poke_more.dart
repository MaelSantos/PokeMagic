import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class PokeMore extends StatelessWidget {
  final Pokemon pokemon;
  Weaknesses get weaknesses => Weaknesses();
  Weakness type;

  PokeMore(this.pokemon) {
    if (pokemon.types.length > 1)
      type = weaknesses.toTwoWeakness(
          pokemon.types[1].type.name, pokemon.types[0].type.name);
    else
      type = weaknesses.toWeakness(pokemon.types[0].type.name);
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
            gerarContainer("",
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
                                child: PokeButton(
                                    t.name + " X${t.damage.toInt()}",
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
                                        " X${t.damage == 0.5 ? '1/2' : '1/4'}",
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
                                child: PokeButton(
                                    t.name + " X${t.damage.toInt()}",
                                    cor: formatColorExist(t.name))))
                            .toList()),
                  ],
                )),
            Text("Sprites"),
            gerarContainer("",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Normal"),
                        imagemSprite(formatNormal(pokemon.number))
                      ],
                    ),
                    Column(
                      children: [
                        Text("Shiny"),
                        imagemSprite(formatShiny(pokemon.number))
                      ],
                    )
                  ],
                )),
          ])),
    );
  }

  Widget imagemSprite(String url) {
    return Container(
        height: 120,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Center(child: Text("No Sprite")),
          fit: BoxFit.contain,
        ));
  }
}
