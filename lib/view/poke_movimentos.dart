import 'package:flutter/material.dart';
import 'package:pokeapi/model/move/move.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokeMove extends StatelessWidget {
  final Pokemon pokemon;
  List<Move> movimentos;
  List<Moves> egg;
  List<Moves> level;
  List<Moves> tutor;
  List<Moves> machine;

  PokeMove(this.pokemon) {
    pokemon.moves.sort((m1, m2) {
      if (m1.versionGroupDetails[0].levelLearnedAt >
          m2.versionGroupDetails[0].levelLearnedAt) return 1;
      if (m1.versionGroupDetails[0].levelLearnedAt <
          m2.versionGroupDetails[0].levelLearnedAt)
        return -1;
      else
        return 0;
    });

    egg = pokemon.moves.where((m) {
      if (m.versionGroupDetails[0].moveLearnMethod.name == "egg") return true;
      return false;
    }).toList();
    level = pokemon.moves.where((m) {
      if (m.versionGroupDetails[0].moveLearnMethod.name == "level-up")
        return true;
      return false;
    }).toList();
    machine = pokemon.moves.where((m) {
      if (m.versionGroupDetails[0].moveLearnMethod.name == "machine")
        return true;
      return false;
    }).toList();
    tutor = pokemon.moves.where((m) {
      if (m.versionGroupDetails[0].moveLearnMethod.name == "tutor") return true;
      return false;
    }).toList();

    teste();
  }

  void teste() async {
    movimentos = List();
    for (Moves m in pokemon.moves) {
      movimentos.add(await PokeAPI.getObject<Move>(int.parse(m.move.id)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                "Movimentos",
                style: TextStyle(fontSize: 23),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("Nível"),
                    Text("Move"),
                    Text("Type"),
                    Text("Acc"),
                    Text("PP"),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Table(
                        // defaultColumnWidth: FixedColumnWidth(10),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        // border: TableBorder(
                        //   horizontalInside: BorderSide(
                        //     color: Colors.black,
                        //     style: BorderStyle.solid,
                        //     width: 1.0,
                        //   ),
                        //   verticalInside: BorderSide(
                        //     color: Colors.black,
                        //     style: BorderStyle.solid,
                        //     width: 1.0,
                        //   ),
                        // ),
                        children: gerarTabela(),
                      )),
                ],
              )

                  // child: ListView(
                  //     children: movimentos
                  //         // .sort((a, b) => a.length.compareTo(b.length))
                  //         .map((t) => Container(
                  //               padding: EdgeInsets.all(20),
                  //               margin: EdgeInsets.all(5),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.red,
                  //                   borderRadius: BorderRadius.circular(15)),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 mainAxisSize: MainAxisSize.max,
                  //                 textBaseline: TextBaseline.alphabetic,
                  //                 crossAxisAlignment: CrossAxisAlignment.end,
                  //                 children: [
                  //                   // Text(t.id.toString(),
                  //                   //     style: TextStyle(
                  //                   //       color: Colors.white,
                  //                   //     )),
                  //                   Text(t.name,
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                       )),
                  //                   Text(t.type.name,
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                       )),
                  //                   Text(
                  //                       t.accuracy != null
                  //                           ? t.accuracy.toString()
                  //                           : "-",
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                       )),
                  //                   Text(t.pp.toString(),
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                       )),
                  //                 ],
                  //               ),
                  //             ))
                  //         .toList()),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  List<TableRow> gerarTabela() {
    List<TableRow> rows = movimentos
        .map(
          (m) => TableRow(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red,
                border: Border.all()),
            children: [
              Container(
                  // margin: EdgeInsets.all(10),
                  padding:  EdgeInsets.all(8),
                  height: 50,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(m.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  )),
              Text(m.type.name,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Text(m.accuracy != null ? m.accuracy.toString() : "-",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Text(m.pp.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ))
            ],
          ),
        )
        .toList();

    // for (int i = 1; i < rows.length; i++) {
    //   rows.insert(i, TableRow(children: [Text(""),Text(""),Text(""),Text("")]));
    // }

    // rows.insert(1, TableRow(children: [Text(""),Text(""),Text(""),Text("")]));

    return rows;
  }
}
