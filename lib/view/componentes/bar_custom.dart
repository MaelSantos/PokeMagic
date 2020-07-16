import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
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
      // barGroupingType: charts.BarGroupingType.grouped,
      // behaviors: [charts.SeriesLegend()],
      // domainAxis:
      //     charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec(), ),
    );
  }

  static charts.Series<Stats, String> createSampleData(List<Stats> list,
      {charts.Color cor, String id = "Stats"}) {
    if (cor == null) cor = charts.MaterialPalette.red.shadeDefault;

    return charts.Series<Stats, String>(
      id: id,
      colorFn: (_, __) => cor,
      domainFn: (Stats s, _) => s.stat,
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
      {charts.Color cor, String id = "Total Stats"}) {
    int soma = 0;
    list.forEach((e) {
      soma += e.baseStat;
    });
    List<Stats> temp = List();
    temp.add(Stats(stat: "Total", baseStat: soma));

    if (cor == null) cor = charts.MaterialPalette.red.shadeDefault;

    return charts.Series<Stats, String>(
      id: id,
      colorFn: (_, __) => cor,
      domainFn: (Stats s, _) => s.stat,
      measureFn: (Stats s, _) => s.baseStat,
      data: temp,
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

    var red = charts.ColorUtil.fromDartColor(Colors.red);
    var green = charts.ColorUtil.fromDartColor(Colors.green);
    var cyan = charts.ColorUtil.fromDartColor(Colors.cyan);

    return charts.Series<Type, String>(
      id: "Types",
      colorFn: (s, __) => charts.ColorUtil.fromDartColor(Colors.cyan),
      areaColorFn: (s, __) => s.damage > 6 ? red : s.damage < 6 ? green : cyan,
      // fillColorFn: (s, __) => s.damage > 6 ? red : s.damage < 6 ? green : cyan,
      // seriesColor:  s.damage > 6 ? red : s.damage < 6 ? green : cyan,
      // patternColorFn: (s, __) => s.damage > 6 ? red : s.damage < 6 ? green : cyan,
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
