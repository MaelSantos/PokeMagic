import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_magic/util.dart/format.dart';
import 'package:poke_magic/util.dart/sqlite.dart';
import 'package:poke_magic/view/poke_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:sqflite/sqflite.dart';

class PokeView extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokeView> {
  List<Pokemon> pokemons;
  int pokemonCont = 890;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    Database db = await SqlUtil().db;
    pokemons = List();
    Pokemon p;
    int i = 1;

    do {
      // print("$i");
      List result =
          await db.query("Pokemon", where: "id = ?", whereArgs: ["$i"]);
      print(result);
      if (result.length > 0) {
        p = Pokemon.fromJson(jsonDecode(result.first["json"]));
      }

      if (p == null) {
        p = await PokeAPI.getObject<Pokemon>(i);
        int insert =
            await db.insert("Pokemon", {"json": "${jsonEncode(p.toJson())}"});
        print("Inserindo: $insert -  Quantidade: $i");
      }
      if (p != null) {
        pokemons.add(p);
        setState(() {});
        i++;
        p = null;
      }
      // print("Incrementado $i");
    } while (i <= pokemonCont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PokéMagic"),
        backgroundColor: Colors.cyan,
      ),
      body: pokemons == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(pokemonCont, (index) {
                return Padding(
                    padding: EdgeInsets.all(2),
                    child: InkWell(
                        onTap: () {
                          if (pokemons.length > index)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PokemonDetalhes(pokemons[index])));
                        },
                        // child: Hero(
                        //     tag: pokemons.length > index
                        //                   ? formatID(pokemons[index].id):"00",
                        child: Card(
                          elevation: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height *
                                  //         0.4,
                                  // width: MediaQuery.of(context).size.width *
                                  //     0.2,
                                  height: 100,
                                  width: 100,
                                  child: pokemons.length > index
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              formatID(pokemons[index].id),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fadeInDuration: Duration(days: 30),
                                          fadeOutDuration: Duration(days: 30),
                                        )
                                      : Container()),
                              pokemons.length > index
                                  ? Text(
                                      "#${pokemons[index].id} - ${pokemons[index].name.replaceRange(0, 1, pokemons[index].name[0].toUpperCase())}")
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ],
                          ),
                        )));
              })),
      drawer: Drawer(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.refresh)),
    );
  }
}
