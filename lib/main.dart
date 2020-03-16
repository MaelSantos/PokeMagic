import 'package:flutter/material.dart';
import 'package:poke_magic/poke_menu.dart';
import 'package:poke_magic/view/accept_policies.dart';
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
                color: Colors.cyan,
                textTheme: TextTheme(
                  title: TextStyle(fontSize: 18, fontFamily: "FredokaOne"),
                )),
            textTheme: TextTheme(
                button: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                subtitle1: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                bodyText1: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                bodyText2: TextStyle(fontSize: 14, fontFamily: "FredokaOne"))),
        home: Entrada(),
        routes: {
          "/Menu": (BuildContext context) => PokeMenu(),
          "/Aceitar": (BuildContext context) => AccpetPolicies(),
        });
  }
}
