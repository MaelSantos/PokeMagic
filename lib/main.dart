import 'package:flutter/material.dart';
import 'package:poke_magic/view/poke_view.dart';

void main() async {
  runApp(PokeMagic());
}

class PokeMagic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PokéMagic",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
              body1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              body2: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ))),
      home: PokeView(),
    );
  }
}
