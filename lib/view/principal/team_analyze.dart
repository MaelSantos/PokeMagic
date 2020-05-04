import 'package:flutter/material.dart';
import 'package:poke_magic/beans/time.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/bar_custom.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class TeamAnalyze extends StatelessWidget {
  final Time time;
  final Pokedex pokedex = Pokedex();
  final Weaknesses weaknesses = Weaknesses();

  List<Pokemon> pokemons;
  List<Type> types;
  int fraqueza, resistencia, normal;
  Map<String, List<Type>> map;

  TeamAnalyze(this.time) {
    pokemons = List();
    map = Map();
    time.indexs.forEach((i) {
      pokemons.add(pokedex.pokemons[i]);
    });
    carregarTypes();
  }

  void carregarTypes() {
    types = List();
    for (Pokemon p in pokemons) {
      for (int i = 0; i < weaknesses.weakness.length; i++) {
        Type w = p.weakness.types
            .firstWhere((e) => e.name == weaknesses.weakness[i].name);
        if (map[weaknesses.weakness[i].name] == null)
          map[weaknesses.weakness[i].name] = [w];
        else {
          List l = map[weaknesses.weakness[i].name];
          l.add(w);
          map[weaknesses.weakness[i].name] = l;
        }
        if (types.length < weaknesses.weakness.length)
          types.add(Type(name: weaknesses.weakness[i].name, damage: w.damage));
        else
          types[i].damage += w.damage;
      }
    }

    fraqueza = 0;
    resistencia = 0;
    normal = 0;
    for (Type t in types) {
      if (t.damage > 6)
        fraqueza++;
      else if (t.damage < 6)
        resistencia++;
      else
        normal++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analyze")),
      body: Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                gerarLegenda(),
                tablePoke(context),
                gerarChart(context),
                gerarTypes()
              ]))),
    );
  }

  Widget gerarLegenda() {
    return gerarContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PokeButton("Good", cor: Colors.green),
            PokeButton("Neutral", cor: Colors.cyan),
            PokeButton("Bad", cor: Colors.red)
          ],
        )
      ],
    ));
  }

  Widget tablePoke(BuildContext context) {
    return gerarContainer(
        child: FittedBox(
            // scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 15,
                columns: datacolum(context),
                rows: datarow())));
  }

  List<DataColumn> datacolum(BuildContext context) {
    List<DataColumn> column = List();
    column.add(DataColumn(label: Text("Types")));

    column.addAll(pokemons
        .map((p) => DataColumn(label: imagemSprite(p.number, context)))
        .toList());

    return column;
  }

  List<DataRow> datarow() {
    List<DataRow> row = List();

    map.forEach((key, value) {
      List<DataCell> cells = List();
      cells.add(DataCell(pokeButton(key, cor: formatColorExist(key))));
      cells.addAll(value
          .map((t) => DataCell(pokeButton("${t.damage}",
              cor: t.damage == 2
                  ? Colors.red
                  : t.damage > 2
                      ? Colors.red[800]
                      : t.damage < 1 ? Colors.green : Colors.cyan)))
          .toList());
      row.add(DataRow(cells: cells));
    });

    return row;
  }

  Widget gerarChart(BuildContext context) {
    return gerarContainer(
        child: Column(children: [
      Text("Sum Damage by Type"),
      Container(
          height: MediaQuery.of(context).size.width + 50,
          child: BarCustom(statsList: [BarCustom.createSampleDataType(types)]))
    ]));
  }

  Widget avaliacao() {
    return gerarContainer(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: resistencia > fraqueza && fraqueza < 5
                ? [Icon(Icons.sentiment_very_satisfied), Text("Very Good")]
                : resistencia > fraqueza
                    ? [Icon(Icons.sentiment_satisfied), Text("Good")]
                    : resistencia == fraqueza
                        ? [Icon(Icons.sentiment_neutral), Text("Neutral")]
                        : resistencia < fraqueza && fraqueza > 7
                            ? [
                                Icon(Icons.sentiment_very_dissatisfied),
                                Text("Very Bad")
                              ]
                            : [
                                Icon(Icons.sentiment_dissatisfied),
                                Text("Bad")
                              ]));
  }

  Widget gerarTypes() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Average by Type"),
      avaliacao(),
      gerarContainer(
          child: Column(
        children: [
          Text("Weakness"),
          Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: types
                  .where((t) => t.damage > 6)
                  .map((t) => FittedBox(
                      fit: BoxFit.contain,
                      child: PokeButton(
                          t.name + " X${(t.damage / 6).toStringAsPrecision(3)}",
                          cor: formatColorExist(t.name))))
                  .toList()),
          Divider(thickness: 2),
          Text("Resistant"),
          Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: types
                  .where((t) => t.damage < 6)
                  .map((t) => FittedBox(
                      fit: BoxFit.contain,
                      child: PokeButton(
                          t.name + " X${(t.damage / 6).toStringAsPrecision(2)}",
                          cor: formatColorExist(t.name))))
                  .toList()),
          Divider(thickness: 2),
          Text("Normal"),
          Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: types
                  .where((t) => t.damage == 6)
                  .map((t) => FittedBox(
                      fit: BoxFit.contain,
                      child: PokeButton(
                          t.name + " X${(t.damage / 6).toStringAsPrecision(2)}",
                          cor: formatColorExist(t.name))))
                  .toList()),
        ],
      ))
    ]);
  }

  Widget pokeButton(String conteudo, {Color cor = Colors.cyan}) {
    return FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        child: FilterChip(
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onSelected: (b) {},
            showCheckmark: false,
            label: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 13, left: 13),
              decoration: BoxDecoration(
                  color: cor, borderRadius: BorderRadius.circular(20)),
              child: Text(conteudo, style: TextStyle(color: Colors.white)),
            )));
  }
}
