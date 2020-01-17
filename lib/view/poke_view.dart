import 'package:cached_network_image/cached_network_image.dart';
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
      body: pokemons == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(890, (index) {
                return Padding(
                    padding: EdgeInsets.all(2),
                    child: InkWell(
                        onTap: () {
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
                                  ?CachedNetworkImage(
                                    imageUrl: formatID(pokemons[index].id),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ):Container()
                                  ),
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
