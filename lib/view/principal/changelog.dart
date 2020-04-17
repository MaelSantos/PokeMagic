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
              gerarFixa("Version 1.0.3", [
                "News: Added Natures",
                "News: Added Team Builder",
              ]),
              gerarFixa("Version 1.0.2", [
                "News: Added 114 new Pokémon details",
                "News: Added EV provided",
                "News: Added locations and routes (Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos)",
              ]),
              gerarFixa("Version 1.0.1", [
                "News: Added comparison function between Pokémon status",
                "Fixed: graphics improvements"
              ])
            ],
          ),
        )));
  }

  Widget gerarFixa(String versao, List<String> modificacoes) {
    return gerarContainer(
        child: Column(
      children: [
        Text(versao),
        Divider(thickness: 2),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: modificacoes.map((e) => Text(e)).toList())
      ],
    ));
  }
}
