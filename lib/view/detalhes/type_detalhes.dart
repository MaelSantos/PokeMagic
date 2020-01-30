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
            title: Text(type.name),
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
                  gerarContainer("",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Name: " + type.name),
                          Text("Damage Class: ${type.moveDamageClass.name}"),
                          Text("Introduced in : ${type.generation.name}")
                        ],
                      )),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Half Damage To"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: type.damageRelations.halfDamageTo
                                    .map((d) => PokeButton("${d.name}",
                                        cor: formatColorExist(d.name)))
                                    .toList()))
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Half Damage From"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: type.damageRelations.halfDamageFrom
                                    .map((d) => PokeButton("${d.name}",
                                        cor: formatColorExist(d.name)))
                                    .toList()))
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Double Damage To"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: type.damageRelations.doubleDamageTo
                                    .map((d) => PokeButton("${d.name}",
                                        cor: formatColorExist(d.name)))
                                    .toList()))
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("Double Damage From"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: type.damageRelations.doubleDamageFrom
                                    .map((d) => PokeButton("${d.name}",
                                        cor: formatColorExist(d.name)))
                                    .toList()))
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("No Damage To"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: type.damageRelations.noDamageTo
                                    .map((d) => PokeButton("${d.name}",
                                        cor: formatColorExist(d.name)))
                                    .toList()))
                      ])),
                  gerarContainer("",
                      child: Column(children: [
                        Text("No Damage From"),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: type.damageRelations.noDamageFrom
                                        .map((d) => PokeButton("${d.name}",
                                            cor: formatColorExist(d.name)))
                                        .toList())))
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
