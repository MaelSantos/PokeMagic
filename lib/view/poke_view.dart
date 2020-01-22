import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/sqlite.dart';
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
  // int pokemonCont = 890;//erro de pokeapi
  int pokemonCont = 807;

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
      // print(result);
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
    return pokemons == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.count(
            // maxCrossAxisExtent: 2,
            crossAxisCount: 2,
            children: List.generate(pokemonCont, (index) {
              return Container(
                  // padding: EdgeInsets.all(2),
                  // margin: EdgeInsets.all(10),
                  // height: 100,
                  // width: 100,
                  // color: pokemons.length > index?formatColor(pokemons[index]):Colors.white,
                  child: InkWell(
                onTap: () {
                  if (pokemons.length > index)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PokemonDetalhes(pokemons[index])));
                },
                child: pokemons.length > index
                    ? Hero(
                        tag: formatID(pokemons[index].id),
                        child: Card(
                            // color: pokemons.length > index
                            //             ? formatColor(pokemons[index])
                            //             : Colors.white,
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: CachedNetworkImage(
                                  imageUrl: formatID(pokemons[index].id),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fadeInDuration: Duration(days: 30),
                                  fadeOutDuration: Duration(days: 30),
                                )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        "#${pokemons[index].id} - ${pokemons[index].name.replaceRange(0, 1, pokemons[index].name[0].toUpperCase())}"),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: pokemons[index]
                                          .types
                                          .reversed
                                          .map((t) => Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: formatColorExist(
                                                        t.type.name),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  t.type.name,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ],
                            )))
                    : Container(),
              ));
            }),
          );
  }
}
