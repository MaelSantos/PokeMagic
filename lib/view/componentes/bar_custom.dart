import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';

class BarCustom extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;

  BarCustom(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
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

  static List<charts.Series<Stats, String>> createSampleData(List<Stats> list) {
    return [
      charts.Series<Stats, String>(
        id: "Stats",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Stats s, _) => s.stat.name,
        measureFn: (Stats s, _) => s.baseStat,
        data: list,
        labelAccessorFn: (Stats sales, _) => "${sales.baseStat}",
        insideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
            color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
        outsideLabelStyleAccessorFn: (Stats sales, _) => charts.TextStyleSpec(
            color: charts.MaterialPalette.white, fontFamily: "FredokaOne"),
      )
    ];
  }
}
