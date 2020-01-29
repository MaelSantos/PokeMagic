import 'package:flutter/material.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/model/pokemon.dart' as poke;
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/move_detalhes.dart';

class PokeMove extends StatefulWidget {
  final poke.Pokemon pokemon;
  final Moves movimentos;

  PokeMove(this.pokemon, this.movimentos);

  @override
  State<StatefulWidget> createState() => PokeMoveState(pokemon, movimentos);
}

class PokeMoveState extends State<PokeMove> {
  final poke.Pokemon pokemon;
  final Moves movimentos;

  List<Move> all;

  String filtro;
  PokeButton btnLevel, btnEgg, btnMachine, btnTutor;

  PokeMoveState(this.pokemon, this.movimentos) {
    filtro = "level-up";

    btnLevel = PokeButton("level-up", selecionado: false, selecionavel: true,
        onSelecionado: (b) {
      filtro = "level-up";
      selecionar(b);
    });
    btnMachine = PokeButton("machine", selecionavel: true, onSelecionado: (b) {
      filtro = "machine";
      selecionar(b);
    });
    btnEgg = PokeButton("egg", selecionavel: true, onSelecionado: (b) {
      filtro = "egg";
      selecionar(b);
    });
    btnTutor = PokeButton("tutor", selecionavel: true, onSelecionado: (b) {
      filtro = "tutor";
      selecionar(b);
    });

    all = movimentos.moves.where((a) {
      for (poke.Move b in pokemon.moves) {
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

    setState(() {
      print(filtro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text("Moves", style: TextStyle(fontSize: 23)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [btnLevel, btnEgg, btnMachine, btnTutor],
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gerarLinha("Nivel", cor: Colors.black, tamanho: 35),
                    gerarLinha("Move", cor: Colors.black, tamanho: 100),
                    gerarLinha("Type", cor: Colors.black),
                    gerarLinha("Acc", cor: Colors.black),
                    gerarLinha("PP", cor: Colors.black, tamanho: 30),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: all
                        .where((m) => m.tipo == filtro)
                        .map((t) => FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MoveDetalhes(t)));
                              },
                              child: Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    gerarLinha(
                                        t.nivel != 0 ? t.nivel.toString() : "-",
                                        tamanho: 35),
                                    gerarLinha(t.name, tamanho: 100),
                                    gerarLinha(t.type.name),
                                    gerarLinha(t.accuracy != null
                                        ? t.accuracy.toString()
                                        : "-"),
                                    gerarLinha(t.pp.toString(), tamanho: 20),
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              )),
            ],
          ),
        ));
  }

  Widget gerarLinha(String conteudo,
      {double tamanho = 60, Color cor = Colors.white}) {
    return Container(
        alignment: Alignment.center,
        width: tamanho,
        margin: EdgeInsets.all(5),
        child: Text(conteudo, style: TextStyle(color: cor)));
  }
}
