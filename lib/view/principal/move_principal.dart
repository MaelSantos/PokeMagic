import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/detalhes/move_detalhes.dart';

class MovePricipal extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<MovePricipal> {
  Moves get move => Moves();

  List<Move> get moves => _filtroPoke(); //move.moves;//;
  int moveCont = 728; //total de pokemons
  bool isFiltro;
  String filtro;
  int get contFiltro => moves.length;

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

  List<Move> _filtroPoke() {
    List<Move> retorno;

    if (move != null && isFiltro)
      retorno = move.moves.where((m) {
        bool ret = true;

        if (pesquisa.text.isNotEmpty)
          ret = m.type.name == filtro && m.name.contains(pesquisa.text);
        else
          ret = m.type.name == filtro ? true : false;

        if (filtro == "all" && pesquisa.text.isNotEmpty)
          ret = m.name.contains(pesquisa.text);

        return ret;
      }).toList();
    else if (move != null) retorno = move.moves;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_down(), pesquisa]),
                    gerarContainer("",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Move"),
                            Text("Power"),
                            Text("Acc"),
                            Text("PP")
                          ],
                        ))
                  ],
                )),
            moves == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                        children: List.generate(
                    isFiltro ? contFiltro : moveCont,
                    (index) {
                      return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MoveDetalhes(moves[index])));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 3,
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(moves[index]
                                                .name
                                                .toUpperCase()),
                                            Text(moves[index].power != null
                                                ? moves[index].power.toString()
                                                : "-"),
                                            Text(moves[index].accuracy != null
                                                ? moves[index]
                                                    .accuracy
                                                    .toString()
                                                : "-"),
                                            Text(moves[index].pp != null
                                                ? moves[index].pp.toString()
                                                : "-"),
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          containerColor(
                                            moves[index].type.name,
                                            formatColorExist(
                                                moves[index].type.name),
                                          ),
                                          containerColor(
                                            moves[index].damageClass.name,
                                            formatColorMove(
                                                moves[index].damageClass.name),
                                          )
                                        ],
                                      ),
                                    ],
                                  ))));
                    },
                  )))
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
