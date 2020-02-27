import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/model/itens.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';

class ItemDetalhes extends StatelessWidget {
  final Item item;

  const ItemDetalhes(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(item.name.toUpperCase())),
        body: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  height: 50,
                  imageUrl: item.sprites.defaultt,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
                gerarContainer("",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name: " + item.name.toUpperCase()),
                        Text("Category: ${item.category.name}"),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Cost "),
                                    Text("${item.cost}"),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Fling Power"),
                                    Text(
                                        "${item.flingPower != null ? item.flingPower : '-'}")
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Fling Effect"),
                                    Text(
                                        "${item.flingEffect != null ? item.flingEffect.name : '-'}")
                                  ]),
                            ]),
                      ],
                    )),
                gerarContainer("Descrition: ${item.flavorTextEntries.text}"),
                gerarContainer("Effect: ${item.effectEntries.shortEffect}"),
                gerarContainer("Effect: ${item.effectEntries.effect}"),
                item.attributes.isNotEmpty
                    ? gerarContainer("",
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          children: item.attributes
                              .map((a) => PokeButton(a.name))
                              .toList(),
                        ))
                    : Container()
              ],
            ),
          ),
        ));
  }

  Widget gerarContainer(String conteudo,
      {double tamanho = 60, Color cor = Colors.black, Widget child}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: child == null
            ? Text(conteudo,
                style: TextStyle(color: cor), textAlign: TextAlign.center)
            : child);
  }
}
