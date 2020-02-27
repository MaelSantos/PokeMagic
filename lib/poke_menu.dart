import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/principal/abilities_principal.dart';
import 'package:poke_magic/view/principal/about.dart';
import 'package:poke_magic/view/principal/favorites_principal.dart';
import 'package:poke_magic/view/principal/itens_principal.dart';
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
  ItensPricipal itensPricipal;
  TypePricipal typePricipal;
  FavoritesPrincipal favoritesPrincipal;
  About about;

  int index;
  String titulo;

  @override
  void initState() {
    pokePricipal = PokePricipal();
    titulo = "PokéMagic";
    index = 1;
    super.initState();

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4785348218475505~7730065377");
  }

  @override
  void dispose() {
    Propaganda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
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
            tile("Pokémons", 1),
            tile("Moves", 2),
            tile("Abilities", 3),
            tile("Items", 4),
            tile("Types", 5),
            tile("Favorites", 6),
            tile("About", 7),
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
        if (itensPricipal == null) itensPricipal = ItensPricipal();
        return itensPricipal;
      case 5:
        if (typePricipal == null) typePricipal = TypePricipal();
        return typePricipal;
      case 6:
        return FavoritesPrincipal();
      case 7:
        if (about == null) about = About();
        return about;

      default:
        return pokePricipal;
    }
  }

  Widget tile(String nome, int i) {
    return Column(children: [
      ListTile(
        title: Text(nome),
        selected: index == i,
        onTap: () {
          setState(() {
            index = i;
            titulo = nome;
            Navigator.pop(context);
          });
        },
      ),
      Divider(thickness: 1),
    ]);
  }
}
