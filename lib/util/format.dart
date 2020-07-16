import 'package:cached_network_image/cached_network_image.dart';
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

Widget gerarContainer({@required Widget child, double spacing = 10}) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black45),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(spacing),
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

Widget imagemSprite(String url, BuildContext context, {double tamanho = 30}) {
  if (url != "#351_f2" &&
      url != "#351_f3" &&
      url != "#351_f4" &&
      url != "#555_f2" &&
      url != "#670_f2" &&
      url != "#745_f3")
    return Container(
        height: tamanho,
        width: tamanho,
        child: CachedNetworkImage(
          imageUrl: formatID(url),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Center(child: Text("No Sprite")),
          fit: BoxFit.contain,
        ));
  else
    return Container(
        height: tamanho, child: Image.asset("assets/temp/$url.png"));
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
  return colors[cor.toLowerCase()];
}

Color formatColorMove(String cor) {
  return colorsMove[cor];
}
