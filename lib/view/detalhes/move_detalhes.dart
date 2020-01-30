import 'package:flutter/material.dart';
import 'package:poke_magic/model/moves.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class MoveDetalhes extends StatelessWidget {
  final Move move;

  const MoveDetalhes(this.move);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(move.name),
            backgroundColor: Colors.cyan),
        body: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  PokeButton(move.type.name,
                      cor: formatColorExist(move.type.name)),
                  move.contestType != null
                      ? PokeButton("${move.contestType.name}",
                          cor: formatColorMove(move.contestType.name))
                      : Container(),
                  PokeButton(move.damageClass.name,
                      cor: formatColorMove(move.damageClass.name)),
                ]),
                gerarContainer("",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name: " + move.name),
                        Text("PP: ${move.pp}"),
                        Text("Power: ${move.power != null ? move.power : '-'}"),
                        Text(
                            "Accuracy: ${move.accuracy != null ? move.accuracy : '-'}"),
                        Text(
                            "Priority: ${move.priority == 0 ? 'normal' : move.priority}"),
                        Text("Category: ${move.meta.category.name}"),
                        Text("Ailment: ${move.meta.ailment.name}"),
                        Text("Target: ${move.target.name}"),
                      ],
                    )),
                gerarContainer(
                    "Descrition: ${move.flavorTextEntries.flavorText}"),
                gerarContainer("Effect: ${move.effectEntries.first.effect}"),
              ],
            ),
          ),
        ));
  }

  Widget gerarContainer(String conteudo,
      {double tamanho = 60, Color cor = Colors.black, Widget child}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: child == null
            ? Text(conteudo, style: TextStyle(color: cor))
            : child);
  }
}
