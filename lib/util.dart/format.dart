import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

String formatID(int i) {
  String linkImagens = "https://www.serebii.net/pokemongo/pokemon/";

  switch (i.toString().length) {
    case 1:
      linkImagens += "00$i.png";
      break;
    case 2:
      linkImagens += "0$i.png";
      break;
    case 3:
      linkImagens += "$i.png";
      break;
    // default:
    //   linkImagens += "$i.png";
  }
  return linkImagens;
}

Map<String, Color> colors = {
  "normal": Colors.blueGrey,
  "fighting": Colors.red[800],
  "flying": Colors.purple[300],
  "poison": Colors.purple,
  "ground": Colors.yellow[700],
  "rock": Colors.blue,
  "bug": Colors.blue,
  "ghost": Colors.blue,
  "steel": Colors.blueGrey[200],
  "fire": Colors.red,
  "water": Colors.blue,
  "grass": Colors.blue,
  "eletric": Colors.blue,
  "psychic": Colors.blue,
  "ice": Colors.blue,
  "dragon": Colors.blue,
  "dark": Colors.blue,
  "fairy": Colors.blue,
};

Color getc(Pokemon pokemon) {
  return colors[pokemon.types[0].type.name];
}
