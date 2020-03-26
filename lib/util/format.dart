import 'package:flutter/material.dart';

String formatID(String i) {
  return "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${i.replaceFirst("#", "")}.png";
}

String formatNormal(String i) {
  return "https://www.serebii.net/pokemongo/pokemon/${i.replaceFirst("#", "")}.png";
}

String formatShiny(String i) {
  // return "https://www.serebii.net/pokemongo/pokemon/${i.replaceFirst("#", "")}.png";
  return "https://www.serebii.net/pokemongo/pokemon/shiny/${i.replaceFirst("#", "")}.png"; //shiny
}

String formatItem(String i) {
  return "https://www.serebii.net/itemdex/sprites/pgl/${i.toLowerCase()}.png";
}

Widget gerarContainer(
    {double tamanho = 60, Color cor = Colors.black, @required Widget child}) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black45),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      child: child);
}

Widget containerColor(String conteudo, Color cor) {
  return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: cor, borderRadius: BorderRadius.circular(15)),
      child: Text(
        conteudo,
        style: TextStyle(color: Colors.white),
      ));
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
