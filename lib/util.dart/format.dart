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
  "normal": Colors.brown[200],
  "fighting": Colors.red[800],
  "flying": Colors.purple[200],
  "poison": Colors.purple,
  "ground": Colors.yellow[700],
  "rock": Colors.lime[900],
  "bug": Colors.lightGreenAccent,
  "ghost": Colors.purple[800],
  "steel": Colors.blueGrey[200],
  "fire": Colors.red,
  "water": Colors.blue,
  "grass": Colors.green[800],
  "electric": Colors.yellow,
  "psychic": Colors.pink,
  "ice": Colors.blue[100],
  "dragon": Colors.purple[900],
  "dark": Colors.brown[900],
  "fairy": Colors.pink[300],
};



Color formatColor(Pokemon pokemon) {
  return colors[pokemon.types[0].type.name];
}

Color formatColorExist(String pokemon) {
  return colors[pokemon];
}
