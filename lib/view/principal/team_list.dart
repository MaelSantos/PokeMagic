import 'package:flutter/material.dart';
import 'package:poke_magic/beans/time.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/principal/team_analyze.dart';
import 'package:poke_magic/view/principal/team_builder.dart';

class TeamList extends StatefulWidget {
  @override
  ListBuilderState createState() => ListBuilderState();
}

class ListBuilderState extends State<TeamList> {
  List<Time> times;
  final Pokedex pokedex = Pokedex();

  @override
  void initState() {
    carregarTimes();
    super.initState();
  }

  void carregarTimes() async {
    times = await Time.getAll();
    setState(() {});
  }

  void update() {
    carregarTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.add),
              tooltip: "Add new team",
              onPressed: () {
                Propaganda.popUp();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TeamBuilder(listBuilderState: this)));
              },
            ),
            times != null
                ? Expanded(
                    child: ListView(
                        children:
                            times.map((t) => pokeTeam(t, context)).toList()))
                : Center(child: CircularProgressIndicator()),
          ],
        ));
  }

  Widget pokeTeam(Time time, BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Propaganda.popUp();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TeamAnalyze(time)));
        },
        onLongPress: () {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: Text("Options: ${time.nome}"),
                actions: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: "Edit team",
                      onPressed: () {
                        // time.remove();
                        // times.remove(time);
                        // setState(() {});
                        // Navigator.of(context).pop();
                        Propaganda.popUp();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamBuilder(
                                    time: time, listBuilderState: this)));
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: "Remove team",
                      onPressed: () {
                        time.remove();
                        times.remove(time);
                        setState(() {});
                        Navigator.of(context).pop();
                      }),
                ],
              ));
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(time.nome),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: time.indexs
                            .map((i) => imagemSprite(
                                pokedex.pokemons[i].number, context))
                            .toList(),
                      ),
                    ]))));
  }
}
