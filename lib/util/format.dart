import 'package:flutter/material.dart';

String formatID(String i) {
  // return "https://www.serebii.net/pokemongo/pokemon/${i.replaceFirst("#", "")}.png";
  // return "https://www.serebii.net/pokemongo/pokemon/shiny/${i.replaceFirst("#", "")}.png"; //shiny
  // "https://www.serebii.net/itemdex/sprites/pgl/sunstone.png" //item
  return "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${i.replaceFirst("#", "")}.png";
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

Map<String, Color> colorsMove = {
  "cute": Colors.pink,
  "cool": Colors.grey[600],
  "beauty": Colors.purple,
  "tough": Colors.yellow[900],
  "smart": Colors.green,

  "physical": Colors.purple[200],
  "special": Colors.blue[900],
  "status": Colors.grey[700],
};

Color formatColorExist(String cor) {
  return colors[cor];
}

Color formatColorMove(String cor) {
  return colorsMove[cor];
}
