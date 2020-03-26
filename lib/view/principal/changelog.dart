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
          child: Column(
            children: [
              gerarFixa("Version 1.0.1", [
                "News: Added comparison function between Pokémon status",
                "Fixed: graphics improvements"
              ])
            ],
          ),
        ));
  }

  Widget gerarFixa(String versao, List<String> modificacoes) {
    return gerarContainer(
        child: Column(
      children: [
        Text(versao, textAlign: TextAlign.center),
        Divider(thickness: 2),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: modificacoes.map((e) => Text(e)).toList())
      ],
    ));
  }
}
