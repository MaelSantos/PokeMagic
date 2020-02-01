import 'package:flutter/material.dart';
import 'package:poke_magic/view/move_principal.dart';
import 'package:poke_magic/view/poke_principal.dart';

class PokeMenu extends StatefulWidget {
  @override
  _PokeMenuState createState() => _PokeMenuState();
}

class _PokeMenuState extends State<PokeMenu> {
  PokePricipal pokePricipal;
  MovePricipal movePricipal;
  int index;
  String titulo;

  @override
  void initState() {
    super.initState();
    pokePricipal = PokePricipal();
    titulo = "PokéMagic";
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("PokéMagic",
                  style: TextStyle(fontSize: 23, color: Colors.white)),
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            ListTile(
              title: Text("Pokémons", style: TextStyle(color: Colors.black)),
              trailing: Text("807"),
              selected: true,
              onTap: () {
                setState(() {
                  index = 1;
                  titulo = "PokéMagic";
                  Navigator.pop(context);
                });
              },
            ),
            Divider(thickness: 1),
            ListTile(
                title: Text("Moves"),
                trailing: Text("-"),
                onTap: () {
                  setState(() {
                    index = 2;
                    titulo = "Moves";
                    Navigator.pop(context);
                  });
                }),
            Divider(thickness: 1),
            ListTile(
              title: Text("Abilities"),
              trailing: Text("-"),
              enabled: false,
              onTap: () {
                setState(() {
                  index = 3;
                  titulo = "Abilities";
                  Navigator.pop(context);
                });
              },
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text("Types"),
              trailing: Text("-"),
              enabled: false,
              onTap: () {
                setState(() {
                  index = 4;
                  titulo = "Types";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      body: tela(),
    );
  }

  Widget tela() {
    switch (index) {
      case 1:
        return pokePricipal;
      case 2:
        if (movePricipal == null) movePricipal = MovePricipal();
        return movePricipal;
      default:
        return pokePricipal;
    }
  }
}
