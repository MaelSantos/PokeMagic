import 'package:flutter/material.dart';

String formatID(String i) {
  return "https://www.serebii.net/pokemongo/pokemon/${i.replaceFirst("#", "")}.png";
}

Map<String, Color> colors = {
  "normal": Colors.brown[200],
  "fighting": Colors.red[800],
  "flying": Colors.purple[200],
  "poison": Colors.purple,
  "ground": Colors.yellow[700],
  "rock": Colors.lime[900],
  "bug": Colors.lightGreenAccent[700],
  "ghost": Colors.purple[800],
  "steel": Colors.blueGrey[200],
  "fire": Colors.red,
  "water": Colors.blue,
  "grass": Colors.green[800],
  "electric": Colors.yellow,
  "psychic": Colors.pink,
  "ice": Colors.blue[200],
  "dragon": Colors.purple[900],
  "dark": Colors.brown[900],
  "fairy": Colors.pink[300],
};

Color formatColorExist(String cor) {
  return colors[cor];
}
