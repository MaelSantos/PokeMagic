import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokeMove extends StatelessWidget {
  final Pokemon pokemon;
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
      print(m.versionGroupDetails[0].moveLearnMethod.name);
      if (m.versionGroupDetails[0].moveLearnMethod.name == "egg") return true;
      return false;
    }).toList();
    level = pokemon.moves.where((m) {
      if (m.versionGroupDetails[0].moveLearnMethod.name == "level-up") return true;
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
              Expanded(
                child: ListView(
                    children: level
                        // .sort((a, b) => a.length.compareTo(b.length))
                        .map((t) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(t.move.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onSelected: (b) {},
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
