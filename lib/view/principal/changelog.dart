import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';

class Changelog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              gerarFixa("Version 1.0.6", [
                "New: Added Generation 8 Pokemon",
                "New: Gigantamax shapes added",
              ]),
              gerarFixa("Version 1.0.5", [
                "New: Team Builder refactoring",
                "Fixed: Bug Fixes",
              ]),
              gerarFixa("Version 1.0.4", [
                "Fixed: Bug Fixes",
              ]),
              gerarFixa("Version 1.0.3", [
                "New: Added Natures",
                "New: Added Team Builder",
              ]),
              gerarFixa("Version 1.0.2", [
                "New: Added 114 new Pokémon details",
                "New: Added EV provided",
                "New: Added locations and routes (Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos)",
              ]),
              gerarFixa("Version 1.0.1", [
                "New: Added comparison function between Pokémon status",
                "Fixed: graphics improvements"
              ])
            ],
          ),
        )));
  }

  Widget gerarFixa(String versao, List<String> modificacoes) {
    return gerarContainer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(versao, textAlign: TextAlign.center)),
        Divider(thickness: 2),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: modificacoes.map((e) => Text(e)).toList())
      ],
    ));
  }
}
