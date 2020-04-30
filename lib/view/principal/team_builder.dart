import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/bar_custom.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class TeamBuilder extends StatefulWidget {
  @override
  _TeamBuilderState createState() => _TeamBuilderState();
}

class _TeamBuilderState extends State<TeamBuilder> {
  final Pokedex pokedex = Pokedex();
  final Weaknesses weaknesses = Weaknesses();
  List<Pokemon> pokemons;
  List<Type> types;
  List<int> indexs;
  int fraqueza, resistencia, normal;

  @override
  void initState() {
    indexs = List();
    fraqueza = 0;
    resistencia = 0;
    normal = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gerarContainer(child: gerarSearch(context)),
          pokemons != null
              ? gerarContainer(
                  child: Column(children: [
                  Text("Damage by Type"),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: tablePoke())
                ]))
              : Container(),
          types != null
              ? gerarContainer(
                  child: Column(children: [
                  Text("Sum Damage by Type"),
                  Container(
                      height: MediaQuery.of(context).size.width+50,
                      child: BarCustom(
                          statsList: [BarCustom.createSampleDataType(types)]))
                ]))
              : Container(),
          types != null ? calcularTypes() : Container(),
        ],
      )),
    );
  }

  Widget imagemSprite(String url, BuildContext context) {
    if (url != "#351_f2" &&
        url != "#351_f3" &&
        url != "#351_f4" &&
        url != "#555_f2" &&
        url != "#670_f2" &&
        url != "#745_f3")
      return Container(
          height: 30,
          width: 30,
          child: CachedNetworkImage(
            imageUrl: formatID(url),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Center(child: Text("No Sprite")),
            fit: BoxFit.contain,
          ));
    else
      return Container(height: 30, child: Image.asset("assets/temp/$url.png"));
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

  Widget gerarSearch(BuildContext context) {
    return SearchableDropdown<Pokemon>.multiple(
        isCaseSensitiveSearch: false,
        hint: Text("Select"),
        // searchHint: "Select",
        isExpanded: true,
        selectedItems: indexs,
        items: pokedex.pokemons
            .map((p) => DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.name),
                    SizedBox(width: 5),
                    imagemSprite(p.number, context)
                  ],
                ),
                value: p))
            .toList(),
        onChanged: (value) {
          indexs = value;
          if (value.length == 6)
            pokemons = indexs.map((i) => pokedex.pokemons[i]).toList();
          else {
            pokemons = null;
            types = null;
            fraqueza = 0;
            resistencia = 0;
            normal = 0;
          }
          setState(() {});
        },
        onClear: () {
          indexs.clear();
          pokemons = null;
          types = null;
          fraqueza = 0;
          resistencia = 0;
          normal = 0;
        },
        selectedValueWidgetFn: (item) {
          if (pokemons != null && item == pokemons.last)
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemons
                    .map((e) => imagemSprite(e.number, context))
                    .toList());
          else
            return SizedBox.shrink();
        },
        doneButton: SizedBox.shrink(),
        closeButton: (itens) => itens.length == 6 ? "Ok" : null,
        validator: (itens) => itens.length < 6
            ? "Select ${(itens.length - 6) * -1} Pokemon's"
            : itens.length > 6
                ? "Deselect ${(itens.length - 6)} Pokemon's"
                : null);
  }

  Widget tablePoke() {
    return DataTable(columnSpacing: 0, columns: datacolum(), rows: datarow());
  }

  List<DataRow> datarow() {
    List<DataRow> row = List();
    types = List();
    for (Pokemon p in pokemons) {
      row.add(DataRow(cells: datacell(p)));
    }
    List<DataCell> cell = List();
    cell.add(DataCell(PokeButton("X")));
    for (Type t in types) {
      cell.add(DataCell(pokeButton("${t.damage}",
          cor: t.damage > 6
              ? Colors.red
              : t.damage < 6 ? Colors.green : Colors.cyan)));
    }
    row.add(DataRow(cells: cell));

    return row;
  }

  List<DataColumn> datacolum() {
    List<DataColumn> column = List();
    column.add(DataColumn(label: PokeButton("")));
    column.addAll(weaknesses.weakness
        .map((w) => DataColumn(
            label: PokeButton(w.name, cor: formatColorExist(w.name)),
            numeric: true))
        .toList());

    return column;
  }

  List<DataCell> datacell(Pokemon p) {
    List<DataCell> cell = List();

    for (int i = 0; i <= weaknesses.weakness.length; i++) {
      if (i == 0)
        cell.add(DataCell(imagemSprite(p.number, context)));
      else {
        Type w = p.weakness.types
            .firstWhere((e) => e.name == weaknesses.weakness[i - 1].name);
        if (types.length < weaknesses.weakness.length)
          types.add(
              Type(name: weaknesses.weakness[i - 1].name, damage: w.damage));
        else
          types[i - 1].damage += w.damage;

        cell.add(DataCell(pokeButton("${w.damage}",
            cor: w.damage > 1
                ? Colors.red
                : w.damage < 1 ? Colors.green : Colors.cyan)));
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

    return cell;
  }

  Widget calcularTypes() {
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
                      child: pokeButton(
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
                      child: pokeButton(
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
                      child: pokeButton(
                          t.name + " X${(t.damage / 6).toStringAsPrecision(2)}",
                          cor: formatColorExist(t.name))))
                  .toList()),
        ],
      ))
    ]);
  }

  Widget pokeButton(String conteudo, {Color cor = Colors.cyan}) {
    return FittedBox(
        alignment: Alignment.centerLeft,
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
