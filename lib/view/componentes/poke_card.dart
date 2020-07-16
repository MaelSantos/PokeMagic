import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/util/format.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final Function onSelecionar;
  final Axis axis;
  final bool fitbox;
  final bool sombras;
  String number = "";
  double size;

  PokeCard(this.pokemon,
      {this.onSelecionar,
      this.size = 14,
      this.axis = Axis.horizontal,
      this.fitbox = false,
      this.sombras = false}) {
    if (pokemon.number != null && pokemon.number.contains("_f"))
      number = pokemon.number.substring(0, pokemon.number.length - 3);
    else
      number = pokemon.number;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onSelecionar,
        // child: Hero(
        //     tag: formatID(pokemon.number),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: sombras ? 0 : 3,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: sombras ? null : Border.all(color: Colors.black12)),
                child: fitbox ? FittedBox(child: principal()) : principal())));
  }

  Widget principal() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pokemon.number != "#351_f2" &&
                  pokemon.number != "#351_f3" &&
                  pokemon.number != "#351_f4" &&
                  pokemon.number != "#555_f2" &&
                  pokemon.number != "#670_f2" &&
                  pokemon.number != "#745_f3"
              ? imagemNet()
              : imagemAsset(),
          axis == Axis.vertical
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: conteudo())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: conteudo())
        ]);
  }

  Widget imagemNet() {
    return Container(
        width: 130,
        height: 130,
        child: CachedNetworkImage(
          imageUrl: formatID(pokemon.number),
          progressIndicatorBuilder: (context, url, download) =>
              CircularProgressIndicator(value: download.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.contain,
        ));
  }

  Widget imagemAsset() {
    Widget ret;

    ret = Container(
        width: 130,
        height: 130,
        child: Image.asset("assets/temp/${pokemon.number}.png"));

    return ret;
  }

  List<Widget> conteudo() {
    return [
      Text("$number - ${pokemon.name}",
          textAlign: TextAlign.center, style: TextStyle(fontSize: size)),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: pokemon.types
                .map((t) => Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: formatColorExist(t),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        t,
                        style: TextStyle(color: Colors.white, fontSize: size),
                      ),
                    ))
                .toList(),
          ))
    ];
  }
}
