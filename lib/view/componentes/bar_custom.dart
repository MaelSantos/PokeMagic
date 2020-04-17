import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:poke_magic/model/comum.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';

// ignore: must_be_immutable
class BarCustom extends StatelessWidget {
  List<charts.Series<dynamic, String>> statsList;
  final bool animate;

  BarCustom({this.statsList, this.animate = true});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      statsList,
      animate: animate,
      vertical: false,
      animationDuration: Duration(milliseconds: 500),
      defaultRenderer: charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(30),
        barRendererDecorator: charts.BarLabelDecorator<String>(
            labelAnchor: charts.BarLabelAnchor.end),
      ),
      // domainAxis:
      //     charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec(), ),
    );
  }

  static charts.Series<Stats, String> createSampleData(List<Stats> list,
      {charts.Color cor}) {
    if (cor == null) cor = charts.MaterialPalette.red.shadeDefault;
    return charts.Series<Stats, String>(
      id: "Stats",
      colorFn: (_, __) => cor,
      domainFn: (Stats s, _) => s.stat.name,
      measureFn: (Stats s, _) => s.baseStat,
      data: list,
      labelAccessorFn: (Stats sales, _) => "${sales.baseStat}",
      insideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
      outsideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
    );
  }

  static charts.Series<Stats, String> createTotalData(List<Stats> list,
      {charts.Color cor}) {
    int soma = 0;
    list.forEach((e) {
      soma += e.baseStat;
    });
    list.clear();
    list.add(Stats(stat: Comum(name: "total"), baseStat: soma));

    if (cor == null) cor = charts.MaterialPalette.red.shadeDefault;

    return charts.Series<Stats, String>(
      id: "Stats",
      colorFn: (_, __) => cor,
      domainFn: (Stats s, _) => s.stat.name,
      measureFn: (Stats s, _) => s.baseStat,
      data: list,
      labelAccessorFn: (Stats sales, _) => "${sales.baseStat}",
      insideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
      outsideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
    );
  }

  static charts.Series<Type, String> createSampleDataType(List<Type> list,
      {charts.Color cor}) {
    if (cor == null) cor = charts.MaterialPalette.red.shadeDefault;

    return charts.Series<Type, String>(
      id: "Types",
      colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
      domainFn: (Type s, _) => s.name,
      measureFn: (Type s, _) => s.damage,
      data: list,
      labelAccessorFn: (Type sales, _) => "${sales.damage}",
      insideLabelStyleAccessorFn: (Type sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
      outsideLabelStyleAccessorFn: (Type sales, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
    );
  }
}
