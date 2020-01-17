import 'package:poke_magic/util.dart/format.dart';
import 'package:poke_magic/view/poke_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokeView extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokeView> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  List<Pokemon> pokemons;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    pokemons = List();
    Pokemon p;
    int i = 1;
    do {
      p = await PokeAPI.getObject<Pokemon>(i);
      pokemons.add(p);
      setState(() {});
      i++;
    } while (p != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PokéMagic"),
        backgroundColor: Colors.cyan,
      ),
      body: pokemons.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokemons
                  .map((poke) => Padding(
                      padding: EdgeInsets.all(2),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PokemonDetalhes(poke)));
                        },
                        child: Hero(
                          tag: formatID(poke.id),
                          child: Card(
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.4,
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.2,
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                formatID(poke.id))),
                                      )),
                                  Text(poke.name.replaceRange(
                                      0, 1, poke.name[0].toUpperCase())),
                                ],
                              )),
                        ),
                      )))
                  .toList(),
            ),
      drawer: Drawer(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.refresh)),
    );
  }
}
