import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/principal/abilities_principal.dart';
import 'package:poke_magic/view/principal/about.dart';
import 'package:poke_magic/view/principal/compare.dart';
import 'package:poke_magic/view/principal/favorites_principal.dart';
import 'package:poke_magic/view/principal/itens_principal.dart';
import 'package:poke_magic/view/principal/locations_principal.dart';
import 'package:poke_magic/view/principal/move_principal.dart';
import 'package:poke_magic/view/principal/nature_principal.dart';
import 'package:poke_magic/view/principal/poke_principal.dart';
import 'package:poke_magic/view/principal/team_builder.dart';
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
  LocationsPrincipal locationsPrincipal;
  TypePricipal typePricipal;
  NaturePricipal naturePricipal;
  FavoritesPrincipal favoritesPrincipal;
  PokeCompare compare;
  TeamBuilder teamBuilder;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("PokéMagic",
                      style: TextStyle(fontSize: 23, color: Colors.white)),
                  Container(child: Image.asset("assets/icon.png", height: 100))
                ],
              ),
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(color: Colors.cyan),
            ),
            tile("Pokémons", 1, iconData: Icons.home),
            tile("Moves", 2, iconData: Icons.flash_on),
            tile("Abilities", 3, iconData: Icons.extension), //flare
            tile("Items", 4, iconData: Icons.local_offer),
            tile("Locations", 5, iconData: Icons.location_on),
            tile("Types", 6, iconData: Icons.category),
            tile("Natures", 7, iconData: Icons.local_florist),
            Divider(thickness: 1),
            tile("Favorites", 8),
            tile("Compare", 9, iconData: Icons.equalizer),
            tile("Team Builder", 10, iconData: Icons.group),
            Divider(thickness: 1),
            tile("About", 11, iconData: Icons.info),
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
        if (locationsPrincipal == null)
          locationsPrincipal = LocationsPrincipal();
        return locationsPrincipal;
      case 6:
        if (typePricipal == null) typePricipal = TypePricipal();
        return typePricipal;
      case 7:
        if (naturePricipal == null) naturePricipal = NaturePricipal();
        return naturePricipal;
      case 8:
        return FavoritesPrincipal();
      case 9:
        if (compare == null) compare = PokeCompare();
        return compare;
      case 10:
        if (teamBuilder == null) teamBuilder = TeamBuilder();
        return teamBuilder;
      case 11:
        if (about == null) about = About();
        return about;

      default:
        return pokePricipal;
    }
  }

  Widget tile(String nome, int i, {IconData iconData = Icons.star}) {
    return Container(
        color: index == i ? Colors.cyan[100] : Colors.transparent,
        child: ListTile(
          title: Row(children: [
            Icon(iconData, color: Colors.grey[800]),
            SizedBox(width: 10),
            Text(nome, style: TextStyle(color: Colors.grey[800]))
          ]),
          onTap: () {
            setState(() {
              index = i;
              titulo = nome;
              Navigator.pop(context);
            });
          },
        ));
  }
}
