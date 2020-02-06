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

    btnLevel = PokeButton("level-up", selecionado: true, selecionavel: true,
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

    setState(() {
      print(filtro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                "",
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
              child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: all
                    .where((m) => m.tipo == filtro)
                    .map((t) => InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Propaganda.popUp();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoveDetalhes(t)));
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(t.nivel != 0
                                              ? t.nivel.toString()
                                              : "-"),
                                          Text(t.name.toUpperCase()),
                                          // Text(t.name),
                                          Text(t.power != null
                                              ? t.power.toString()
                                              : "-"),
                                          Text(t.accuracy != null
                                              ? t.accuracy.toString()
                                              : "-"),
                                          Text(t.pp != null
                                              ? t.pp.toString()
                                              : "-"),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Type: "),
                                        containerColor(
                                          t.type.name,
                                          formatColorExist(t.type.name),
                                        ),
                                        containerColor(
                                          t.damageClass.name,
                                          formatColorMove(t.damageClass.name),
                                        )
                                      ],
                                    ),
                                  ],
                                )))))
                    .toList()),
          )),
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
}
