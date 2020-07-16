import 'package:flutter/material.dart';
import 'package:poke_magic/beans/time.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/weaknesses.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/componentes/poke_card.dart';
import 'package:poke_magic/view/principal/team_analyze.dart';
import 'package:poke_magic/view/principal/team_list.dart';
import 'package:poke_magic/view/segundario/poke_view.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class TeamBuilder extends StatefulWidget {
  Time time;
  ListBuilderState listBuilderState;

  TeamBuilder({this.time, this.listBuilderState});

  @override
  _TeamBuilderState createState() =>
      _TeamBuilderState(time: time, listBuilderState: listBuilderState);
}

class _TeamBuilderState extends State<TeamBuilder> {
  final Pokedex pokedex = Pokedex();
  final Weaknesses weaknesses = Weaknesses();
  List<Pokemon> pokemons;
  List<int> indexs;
  Time time;
  ListBuilderState listBuilderState;

  FieldCustom txtNome;

  _TeamBuilderState({this.time, this.listBuilderState});

  @override
  void initState() {
    txtNome = FieldCustom("New Team");
    if (time != null) {
      indexs = time.indexs;
      txtNome.controlador.text = time.nome;
      pokemons = indexs.map((i) => pokedex.pokemons[i]).toList();
    } else {
      indexs = List();
      txtNome.controlador.text = "New Team";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Team Builder"),
          actions: [
            Builder(
                builder: (context) => IconButton(
                      icon: Icon(Icons.save),
                      tooltip: "Save",
                      onPressed: () {
                        if (indexs.length == 6) {
                          if (time == null || time.id == null) {
                            time = Time();
                            time.setIndexs(indexs);
                            time.nome = txtNome.text;
                            time.save();
                          } else {
                            time.setIndexs(indexs);
                            time.nome = txtNome.text;
                            time.update();
                          }
                          if (listBuilderState != null)
                            listBuilderState.update();

                          Navigator.pop(context);
                        } else
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Select 6 Pokemon's"),
                              duration: Duration(seconds: 3)));
                      },
                    )),
            Builder(
                builder: (context) => IconButton(
                      icon: Icon(Icons.equalizer),
                      tooltip: "Analyze",
                      onPressed: () {
                        if (indexs.length == 6) {
                          if (time == null) {
                            time = Time();
                            time.setIndexs(indexs);
                          }
                          Propaganda.popUp();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamAnalyze(time)));
                        } else
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Select 6 Pokemon's"),
                              duration: Duration(seconds: 3)));
                      },
                    ))
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              txtNome,
              SizedBox(height: 5),
              gerarContainer(child: gerarSearch(context)),
              Text("Pokemon's selected"),
              pokemons != null ? gerarPokemons(context) : Container(),
            ],
          ),
        ));
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
          print(indexs.length);
          if (indexs.length <= 6)
            pokemons = indexs.map((i) => pokedex.pokemons[i]).toList();
          else {
            pokemons = null;
          }

          setState(() {});
        },
        onClear: () {
          indexs.clear();
          pokemons = null;
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

  Widget gerarPokemons(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 3,
      children: pokemons
          .map((p) => PokeCard(p, fitbox: true, onSelecionar: () {
                Propaganda.popUp();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PokeView(p)));
              }))
          .toList(),
    ));
  }
}
