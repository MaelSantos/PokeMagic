import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/principal/abilities_principal.dart';
import 'package:poke_magic/view/principal/move_principal.dart';
import 'package:poke_magic/view/principal/poke_principal.dart';
import 'package:poke_magic/view/principal/type_principal.dart';

class PokeMenu extends StatefulWidget {
  @override
  _PokeMenuState createState() => _PokeMenuState();
}

class _PokeMenuState extends State<PokeMenu> {
  PokePricipal pokePricipal;
  MovePricipal movePricipal;
  AbilitiesPricipal abilitiesPricipal;
  TypePricipal typePricipal;
  int index;
  String titulo;

  @override
  void initState() {
    pokePricipal = PokePricipal();
    titulo = "PokéMagic";
    index = 1;
    super.initState();
    // movePricipal = MovePricipal();
    // abilitiesPricipal = AbilitiesPricipal();
    // typePricipal = TypePricipal();

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4785348218475505~7730065377");

    // Future.delayed(Duration(minutes: 5), Propaganda.displayInterstitial());
  }

  @override
  void dispose() {
    Propaganda.dispose();
    super.dispose();
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
                // image: DecorationImage(
                //   image: AssetImage("assets/icon.png"),
                //   fit: BoxFit.scaleDown,
                //   alignment: Alignment.center
                // )
              ),
            ),
            ListTile(
              title: Text("Pokémons"),
              selected: index == 1,
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
                selected: index == 2,
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
              selected: index == 3,
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
              selected: index == 4,
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
    Propaganda.popUp();
    switch (index) {
      case 1:
        return pokePricipal;
      case 2:
        if (movePricipal == null) movePricipal = MovePricipal();
        return movePricipal;
      case 3:
        if (abilitiesPricipal == null) abilitiesPricipal = AbilitiesPricipal();
        return abilitiesPricipal;
      case 4:
        if (typePricipal == null) typePricipal = TypePricipal();
        return typePricipal;
      default:
        return pokePricipal;
    }
  }
}
