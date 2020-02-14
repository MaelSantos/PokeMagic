import 'package:poke_magic/model/pokedex.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';
import 'package:poke_magic/util/propaganda.dart';

class PokePricipal extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokePricipal> {
  Pokedex pokedex = Pokedex();

  List<Pokemon> get pokemons => _filtroPoke();
  int pokemonCont = 807; //total de pokemons
  bool isFiltro;
  String filtro;
  int get contFiltro => pokemons.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    isFiltro = false;
    filtro = "all";
    pesquisa = FieldCustom("Search", iconData: Icons.search, onDigitar: (s) {
      setState(() {
        if (s.isEmpty && filtro == "all")
          isFiltro = false;
        else
          isFiltro = true;
      });
    });
    super.initState();
  }

  List<Pokemon> _filtroPoke() {
    List<Pokemon> retorno;

    if (pokedex != null && isFiltro)
      retorno = pokedex.pokemons.where((p) {
        bool ret = true;

        for (PokemonTypes t in p.types) {
          ret = t.type.name == filtro ? true : false;
          if (pesquisa.text.isNotEmpty)
            ret = t.type.name == filtro && p.name.contains(pesquisa.text)
                ? true
                : false;
          if (ret) break;
        }
        if (filtro == "all" && pesquisa.text.isNotEmpty)
          ret = p.name.contains(pesquisa.text);

        return ret;
      }).toList();
    else if (pokedex != null) retorno = pokedex.pokemons;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _down(),
                    pesquisa,
                  ],
                )),
            pokemons == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(isFiltro ? contFiltro : pokemonCont,
                        (index) {
                      return PokeCard(
                        pokemons[index],
                        fitbox: true,
                        onSelecionar: () {
                          if (pokemons.length > index) {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PokeView(pokemons[index])));
                          }
                        },
                      );
                    }),
                  ))
          ],
        ));
  }

  DropdownButton _down() => DropdownButton<String>(
        items: [
          DropdownMenuItem(value: "all", child: Text("All")),
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
            if (p == "all")
              isFiltro = false;
            else
              isFiltro = true;
            filtro = p;
          });
        },
        value: filtro,
      );
}
