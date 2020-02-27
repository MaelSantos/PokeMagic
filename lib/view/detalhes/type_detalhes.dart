import 'package:flutter/material.dart';
import 'package:poke_magic/model/types.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class TypeDetalhes extends StatelessWidget {
  final Type type;

  const TypeDetalhes(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(type.name.toUpperCase())),
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
                  gerarContainer("",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Name: " + type.name.toUpperCase()),
                          type.moveDamageClass != null
                              ? Text(
                                  "Damage Class: ${type.moveDamageClass.name}")
                              : Container(),
                          Text("Introduced in : ${type.generation.name}")
                        ],
                      )),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Half Damage To - 1/2X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.halfDamageTo
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Half Damage From - 1/2X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.halfDamageFrom
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Double Damage To - 2X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.doubleDamageTo
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Double Damage From - 2X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.doubleDamageFrom
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("No Damage To - 0X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.noDamageTo
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("No Damage From - 0X"),
                        Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: type.damageRelations.noDamageFrom
                                .map((d) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: PokeButton("${d.name}",
                                        cor: formatColorExist(d.name))))
                                .toList())
                      ])),
                ]))));
  }

  Widget gerarContainer(String conteudo,
      {Color cor = Colors.black, Widget child}) {
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
