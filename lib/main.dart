import 'package:flutter/material.dart';
import 'package:poke_magic/poke_menu.dart';
import 'package:poke_magic/view/entrada.dart';

void main() => runApp(PokeMagic());

class PokeMagic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PokéMagic",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    title: TextStyle(fontSize: 18, fontFamily: "FredokaOne"))),
            textTheme: TextTheme(
                button: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                subhead: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                body1: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                body2: TextStyle(fontSize: 14, fontFamily: "FredokaOne"))),
        home: Entrada(),
        routes: {
          "/Menu": (BuildContext context) => PokeMenu(),
        });
  }
}
