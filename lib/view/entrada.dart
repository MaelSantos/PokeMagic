import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import "package:flutter/services.dart" show rootBundle;
import 'package:poke_magic/model/abilitys.dart';
import 'package:poke_magic/model/evolutions.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:flutter/services.dart';
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

  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, '/Menu');
  }

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 5); //duração de exibição
    return Timer(_duration, navigationToNextPage);
  }

  carregarPokedex() async {
    pokedex = Pokedex.fromJson(await carregarJson("assets/data/pokedex.json"));
    moves = Moves.fromJson(await carregarJson("assets/data/moves.json"));
    evolutions = Evolutions.fromJson(await carregarJson("assets/data/evolutions.json"));
    abilitys = Abilitys.fromJson(await carregarJson("assets/data/abilitys.json"));
    types = Types.fromJson(await carregarJson("assets/data/types.json"));
    weaknesses = Weaknesses.fromJson(await carregarJson("assets/data/weakness.json"));
  }

  Future<Map<String, dynamic>> carregarJson(String url) async {
    String raw = await rootBundle.loadString(url);
    Map<String, dynamic> data = await json.decode(raw);
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
                height: 250,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon.png", fit: BoxFit.contain),
                    Text("PokéMagic", style: TextStyle(fontSize: 25))
                  ],
                ))));
  }
}
