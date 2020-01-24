import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/sqlite.dart';

import 'package:flutter/material.dart';
import 'package:poke_magic/view/poke_view.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:sqflite/sqflite.dart';

class PokePricipal extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokePricipal> {
  List<Pokemon> poke;
  List<Pokemon> get pokemons => _filtroPoke();
  int pokemonCont = 807; //total de pokemons
  bool isFiltro;
  String filtro;
  int get contFiltro => pokemons.length;

  @override
  void initState() {
    isFiltro = false;
    filtro = "todos";
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    Database db = await SqlUtil().db;
    poke = List();
    Pokemon p;
    int i = 1;

    do {
      List result =
          await db.query("Pokemon", where: "id = ?", whereArgs: ["$i"]);
      if (result.length > 0) {
        p = Pokemon.fromJson(jsonDecode(result.first["json"]));
      }

      if (p == null) {
        p = await PokeAPI.getObject<Pokemon>(i);
        db.insert("Pokemon", {"json": "${jsonEncode(p.toJson())}"});
      }
      if (p != null) {
        poke.add(p);
        setState(() {});
        i++;
        p = null;
      }
    } while (i <= pokemonCont);

    // pokemons = pokemons.reversed.toList();
    // setState(() {});
  }

  List<Pokemon> _filtroPoke() {
    List<Pokemon> retorno;

    if (poke != null && isFiltro)
      retorno = poke.where((p) {
        bool ret = true;

        for(Types t in p.types){
          ret = t.type.name == filtro ? true : false;
          if (ret) break;
        }

        return ret;
      }).toList();
    else
      retorno = poke;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: _down(),
        ),
        pokemons == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                // alignment: Alignment.center,
                child: GridView.count(
                crossAxisCount: 2,
                children:
                    List.generate(isFiltro ? contFiltro : pokemonCont, (index) {
                  return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (pokemons.length > index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PokeView(pokemons[index])));
                      },
                      child: Hero(
                          tag: pokemons.length > index
                              ? formatID(pokemons[index].id)
                              : "0",
                          child: Card(
                            // color: pokemons.length > index
                            //             ? formatColor(pokemons[index])
                            //             : Colors.white,
                            elevation: 3,
                            child: pokemons.length > index
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: CachedNetworkImage(
                                        imageUrl: formatID(pokemons[index].id),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      margin: EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              formatColorExist(
                                                                  t.type.name),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Text(
                                                        t.type.name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                          )));
                }),
              ))
      ],
    );
  }

  DropdownButton _down() => DropdownButton<String>(
        items: [
          DropdownMenuItem(value: "todos", child: Text("Todos")),
          DropdownMenuItem(value: "normal", child: Text("Normal")),
          DropdownMenuItem(value: "fighting", child: Text("Fighting")),
          DropdownMenuItem(value: "flying", child: Text("Flying")),
          DropdownMenuItem(value: "poison", child: Text("Poison")),
          DropdownMenuItem(value: "ground", child: Text("Ground")),
          DropdownMenuItem(value: "rock", child: Text("Rock")),
          DropdownMenuItem(value: "bug", child: Text("Bug")),
          DropdownMenuItem(value: "ghost", child: Text("Ghost")),
          DropdownMenuItem(value: "steel", child: Text("Steel")),
          DropdownMenuItem(value: "fire", child: Text("Fire")),
          DropdownMenuItem(value: "water", child: Text("Water")),
          DropdownMenuItem(value: "grass", child: Text("Grass")),
          DropdownMenuItem(value: "electric", child: Text("Electric")),
          DropdownMenuItem(value: "psychic", child: Text("Psychic")),
          DropdownMenuItem(value: "ice", child: Text("Ice")),
          DropdownMenuItem(value: "dragon", child: Text("Dragon")),
          DropdownMenuItem(value: "dark", child: Text("Dark")),
          DropdownMenuItem(value: "fairy", child: Text("Fairy")),
        ],
        onChanged: (p) {
          setState(() {
            if (p == "todos")
              isFiltro = false;
            else
              isFiltro = true;
            filtro = p;
          });
        },
        value: filtro,
      );
}
