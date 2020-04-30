import 'package:flutter/material.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/detalhes/move_detalhes.dart';
import 'package:poke_magic/util/propaganda.dart';

class PokeMove extends StatefulWidget {
  final Pokemon pokemon;

  PokeMove(this.pokemon);

  @override
  State<StatefulWidget> createState() => PokeMoveState(pokemon);
}

class PokeMoveState extends State<PokeMove> {
  final Pokemon pokemon;
  Moves get movimentos => Moves();

  List<Move> all;

  String filtro;
  PokeButton btnLevel, btnEgg, btnMachine, btnTutor;

  PokeMoveState(this.pokemon) {
    filtro = "level-up";

    btnLevel = PokeButton("Level-Up", selecionado: true, selecionavel: true,
        onSelecionado: (b) {
      filtro = "level-up";
      selecionar(b);
    });
    btnMachine = PokeButton("Machine", selecionavel: true, onSelecionado: (b) {
      filtro = "machine";
      selecionar(b);
    });
    btnEgg = PokeButton("Egg", selecionavel: true, onSelecionado: (b) {
      filtro = "egg";
      selecionar(b);
    });
    btnTutor = PokeButton("Tutor", selecionavel: true, onSelecionado: (b) {
      filtro = "tutor";
      selecionar(b);
    });

    all = movimentos.moves.where((a) {
      for (PokemonMove b in pokemon.moves) {
        if (a.name == b.move.name) {
          a.nivel = b.versionGroupDetails.levelLearnedAt;
          a.tipo = b.versionGroupDetails.moveLearnMethod.name;
          return true;
        }
      }
      return false;
    }).toList();

    all.sort((a, b) {
      if (a.nivel > b.nivel)
        return 1;
      else if (a.nivel < b.nivel)
        return -1;
      else if (a.nivel > b.nivel) return 0;
      return 0;
    });
  }

  void selecionar(bool b) {
    switch (filtro) {
      case "level-up":
        btnLevel.selecionar(true);
        btnEgg.selecionar(false);
        btnMachine.selecionar(false);
        btnTutor.selecionar(false);
        break;
      case "egg":
        btnLevel.selecionar(false);
        btnEgg.selecionar(true);
        btnMachine.selecionar(false);
        btnTutor.selecionar(false);
        break;
      case "machine":
        btnLevel.selecionar(false);
        btnEgg.selecionar(false);
        btnMachine.selecionar(true);
        btnTutor.selecionar(false);
        break;
      case "tutor":
        btnLevel.selecionar(false);
        btnEgg.selecionar(false);
        btnMachine.selecionar(false);
        btnTutor.selecionar(true);
        break;
      default:
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("Moves", style: TextStyle(fontSize: 23)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [btnLevel, btnEgg, btnMachine, btnTutor],
              ),
              gerarContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gerarLinha("Nivel", cor: Colors.black, tamanho: 40),
                    gerarLinha("Move", cor: Colors.black, tamanho: 70),
                    gerarLinha("Power", cor: Colors.black),
                    gerarLinha("Acc", cor: Colors.black),
                    gerarLinha("PP", cor: Colors.black, tamanho: 30),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: all
                            .where((m) => m.tipo == filtro)
                            .map((move) => moveCard(move))
                            .toList()),
                  ))),
        ],
      ),
    );
  }

  Widget gerarLinha(String conteudo,
      {double tamanho = 60, Color cor = Colors.white}) {
    return Container(
        alignment: Alignment.center,
        width: tamanho,
        margin: EdgeInsets.all(5),
        child: Text(conteudo, style: TextStyle(color: cor)));
  }

  Widget moveCard(Move move) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Propaganda.popUp();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MoveDetalhes(move)));
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(move.nivel != 0 ? move.nivel.toString() : "-"),
                          Text(move.name.toUpperCase()),
                          Text(
                              "${move.power != null ? move.power.toString() : "-"}"),
                          Text(
                              "${move.accuracy != null ? move.accuracy.toString() : "-"}"),
                          Text("${move.pp != null ? move.pp.toString() : "-"}")
                        ]),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Type: "),
                        containerColor(
                            move.type.name, formatColorExist(move.type.name)),
                        containerColor(move.damageClass.name,
                            formatColorMove(move.damageClass.name)),
                      ],
                    ),
                  ],
                ))));
  }
}
