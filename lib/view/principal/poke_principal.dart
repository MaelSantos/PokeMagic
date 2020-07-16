import 'package:poke_magic/model/pokedex.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
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
  int get pokemonCont => pokedex.pokemons.length;
  bool isFiltro;
  String filtro, filtro2;
  int get contFiltro => pokemons.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    isFiltro = false;
    filtro = "all";
    filtro2 = "all";
    pesquisa = FieldCustom("Search", iconData: Icons.search, onDigitar: (s) {
      setState(() {
        if (s.isEmpty && filtro == "all" && filtro2 == "all")
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

        if (filtro != "all")
          for (String t in p.types) {
            if (filtro2 != "all")
              ret = t.toLowerCase() == filtro && p.generation == filtro2;
            else
              ret = t.toLowerCase() == filtro;

            if (pesquisa.text.trim().isNotEmpty) {
              if (filtro2 != "all")
                ret = t.toLowerCase() == filtro &&
                    p.generation == filtro2 &&
                    p.name.toLowerCase().contains(pesquisa.text);
              else
                ret = t.toLowerCase() == filtro &&
                    p.name.toLowerCase().contains(pesquisa.text);
            }
            if (ret) break;
          }
        else if (pesquisa.text.trim().isNotEmpty) {
          if (filtro2 != "all")
            ret = p.generation == filtro2 &&
                p.name.toLowerCase().contains(pesquisa.text);
          else
            ret = p.name.toLowerCase().contains(pesquisa.text);
        } else if (filtro2 != "all") ret = p.generation == filtro2;

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
                  children: [_down(), _gen(), pesquisa],
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
                      // if (index < pokedex.pokemons.length)
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
                      // else
                      //   return emBreve(index, context);
                    }),
                  ))
          ],
        ));
  }

  Widget emBreve(int i, BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Coming Soon"), duration: Duration(seconds: 3)));
        },
        child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                Align(
                    child: Opacity(
                        opacity: 0.5,
                        child: FittedBox(
                            child: Container(
                                padding: EdgeInsets.all(4),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      imagemSprite("${i - 114}", context,
                                          tamanho: 130),
                                      Text("#${i - 114}"),
                                    ]))))),
                Align(child: Text("Coming Soon")),
              ],
            )));
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
            if (p == "all" && filtro2 == "all" && pesquisa.text.trim().isEmpty)
              isFiltro = false;
            else
              isFiltro = true;
            filtro = p;
          });
        },
        value: filtro,
      );

  DropdownButton _gen() => DropdownButton<String>(
        items: [
          DropdownMenuItem(value: "all", child: Text("All")),
          DropdownMenuItem(value: "I", child: Text("Gen I")),
          DropdownMenuItem(value: "II", child: Text("Gen II")),
          DropdownMenuItem(value: "III", child: Text("Gen III")),
          DropdownMenuItem(value: "IV", child: Text("Gen IV")),
          DropdownMenuItem(value: "V", child: Text("Gen V")),
          DropdownMenuItem(value: "VI", child: Text("Gen VI")),
          DropdownMenuItem(value: "VII", child: Text("Gen VII")),
          DropdownMenuItem(value: "VIII", child: Text("Gen VIII")),
        ],
        onChanged: (p) {
          setState(() {
            if (p == "all" && filtro == "all" && pesquisa.text.trim().isEmpty)
              isFiltro = false;
            else
              isFiltro = true;
            filtro2 = p;
          });
        },
        value: filtro2,
      );
}
