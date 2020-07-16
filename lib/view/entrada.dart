import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import "package:flutter/services.dart" show rootBundle;
import 'package:poke_magic/beans/configuracao.dart';
import 'package:poke_magic/model/abilitys.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/forms.dart';
import 'package:poke_magic/model/itens.dart';
import 'package:poke_magic/model/locations.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/model/natures.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/types.dart';
import 'package:poke_magic/model/weaknesses.dart';

class Entrada extends StatefulWidget {
  @override
  EntradaState createState() => EntradaState();
}

class EntradaState extends State<Entrada> {
  Pokedex pokedex;
  Moves moves;
  Evolutions evolutions;
  Abilitys abilitys;
  Types types;
  Weaknesses weaknesses;
  Forms forms;
  Itens itens;
  Locations locations;
  Natures natures;

  void navigationToNextPage() async {
    Configuracao configuracao = await Configuracao.getId(1);
    if (configuracao != null) {
      if (configuracao.policies)
        Navigator.pushReplacementNamed(context, '/Menu');
      else
        Navigator.pushReplacementNamed(context, '/Aceitar');
    } else {
      configuracao = Configuracao();
      configuracao.save();
      Navigator.pushReplacementNamed(context, '/Aceitar');
    }
  }

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 5); //duração de exibição
    return Timer(_duration, navigationToNextPage);
  }

  carregarPokedex() async {
    weaknesses = Weaknesses.fromJson(await carregarJson("assets/data/weakness.json"));
    pokedex = Pokedex.fromJson(await carregarJson("assets/data/pokedex.json"));
    moves = Moves.fromJson(await carregarJson("assets/data/moves.json"));
    evolutions = Evolutions.fromJson(await carregarJson("assets/data/evolutions.json"));
    abilitys = Abilitys.fromJson(await carregarJson("assets/data/abilitys.json"));
    types = Types.fromJson(await carregarJson("assets/data/types.json"));
    itens = Itens.fromJson(await carregarJson("assets/data/itens.json"));
    forms = Forms.fromJson(await carregarJson("assets/data/forms.json"));
    natures = Natures.fromJson(await carregarJson("assets/data/nature.json"));
    locations = Locations.fromJson(await carregarJson("assets/data/locations.json"));
  }

  Future<dynamic> carregarJson(String url) async {
    String raw = await rootBundle.loadString(url);
    var data = await json.decode(raw);
    return data;
  }

  @override
  void initState() {
    carregarPokedex();
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: Center(
            child: Container(
                // color: Colors.blue,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon.png", fit: BoxFit.contain),
                    SizedBox(height: 5),
                    // Text("MagicDex", style: TextStyle(fontSize: 25))
                  ],
                )))));
  }
}
