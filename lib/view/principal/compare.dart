import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/componentes/bar_custom.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class PokeCompare extends StatefulWidget {
  @override
  _PokeCompareState createState() => _PokeCompareState();
}

class _PokeCompareState extends State<PokeCompare> {
  final Pokedex pokedex = Pokedex();
  final Weaknesses weaknesses = Weaknesses();
  Pokemon pokemon1, pokemon2;
  Weakness type1, type2;
  String nome1, nome2;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(4),
            child: Column(
              children: [
                gerarContainer(
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              gerarSearch(pokemon1, 1, context),
                              gerarSearch(pokemon2, 2, context),
                            ]))),
                pokemon1 == null || pokemon2 == null
                    ? Center(child: Text("Select Pokémons"))
                    : compare()
              ],
            )));
  }

  Widget compare() {
    return Column(children: [
      gerarContainer(
          child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gerarFixa(pokemon1, type1),
                  VerticalDivider(thickness: 2, color: Colors.black),
                  gerarFixa(pokemon2, type2),
                ],
              ))),
      gerarContainer(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "${pokemon1.name.replaceRange(0, 1, pokemon1.name[0].toUpperCase())}:"),
              PokeButton("", cor: Colors.cyan),
              Text(
                  "${pokemon2.name.replaceRange(0, 1, pokemon2.name[0].toUpperCase())}:"),
              PokeButton("", cor: Colors.teal),
            ],
          ),
          VerticalDivider(thickness: 2),
          Container(
            height: MediaQuery.of(context).size.width * 0.85,
            child: BarCustom(statsList: [
              BarCustom.createSampleData(pokemon1.stats.reversed.toList(),
                  cor: charts.MaterialPalette.cyan.shadeDefault,
                  id: pokemon1.name),
              BarCustom.createSampleData(pokemon2.stats.reversed.toList(),
                  cor: charts.MaterialPalette.teal.shadeDefault,
                  id: pokemon2.name),
            ]),
          ),
          Container(
              height: MediaQuery.of(context).size.width * 0.20,
              child: BarCustom(statsList: [
                BarCustom.createTotalData(pokemon1.stats.reversed.toList(),
                    cor: charts.MaterialPalette.cyan.shadeDefault,
                    id: pokemon1.name),
                BarCustom.createTotalData(pokemon2.stats.reversed.toList(),
                    cor: charts.MaterialPalette.teal.shadeDefault,
                    id: pokemon2.name),
              ])),
        ],
      ))
    ]);
  }

  Weakness getType(Pokemon p) {
    return weaknesses.toPokeWeakness(p);
  }

  Widget imagemSprite(String url, BuildContext context) {
    if (url != "#351_f2" &&
        url != "#351_f3" &&
        url != "#351_f4" &&
        url != "#555_f2" &&
        url != "#670_f2" &&
        url != "#745_f3")
      return Container(
          height: 30,
          child: CachedNetworkImage(
            imageUrl: formatID(url),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Center(child: Text("No Sprite")),
            fit: BoxFit.contain,
          ));
    else
      return Container(height: 30, child: Image.asset("assets/temp/$url.png"));
  }

  Widget gerarFixa(Pokemon p, Weakness t) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PokeCard(p, sombras: true, fitbox: true, onSelecionar: () {
          Propaganda.popUp();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PokeView(p)));
        }),
        Divider(thickness: 2),
        Text("Weakness by type"),
        Text("Weakness: ${t.types.where((e) => e.damage > 1).length}"),
        Text(
            "Resistant or Imunne: ${t.types.where((e) => e.damage < 1).length}"),
        Text("Normal Damage: ${t.types.where((e) => e.damage == 1).length}"),
      ],
    );
  }

  Widget gerarSearch(Pokemon p, int i, BuildContext context) {
    return SearchableDropdown.single(
        closeButton: null,
        displayClearIcon: false,
        isCaseSensitiveSearch: false,
        value: p,
        hint: Text("Select"),
        items: pokedex.pokemons
            .map((p) => DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.name),
                    SizedBox(width: 5),
                    imagemSprite(p.number, context)
                  ],
                ),
                value: p))
            .toList(),
        onChanged: (value) {
          setState(() {
            if (i == 1 && value != null) {
              pokemon1 = value;
              if (pokemon1 != null) type1 = getType(pokemon1);
            } else if (i == 2 && value != null) {
              pokemon2 = value;
              if (pokemon2 != null) type2 = getType(pokemon2);
            }
            p = value;
          });
        });
  }
}
