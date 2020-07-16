import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_magic/model/itens.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/detalhes/item_detalhe.dart';

class ItensPricipal extends StatefulWidget {
  @override
  _ItensPrincipalState createState() => _ItensPrincipalState();
}

class _ItensPrincipalState extends State<ItensPricipal> {
  Itens get item => Itens();

  List<Item> get itens => _filtroPoke(); //item.itens;//;
  int itemCont = 903; //total de itens
  bool isFiltro;
  String filtro;
  int get contFiltro => itens.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    isFiltro = false;
    filtro = "all";
    pesquisa = FieldCustom("Search", iconData: Icons.search, onDigitar: (s) {
      setState(() {
        if (s.isEmpty && filtro == "all")
          isFiltro = false;
        else
          isFiltro = true;
      });
    });
    super.initState();
  }

  List<Item> _filtroPoke() {
    List<Item> retorno;

    if (item != null && isFiltro)
      retorno = item.itens.where((m) {
        bool ret = true;

        // if (pesquisa.text.isNotEmpty)
        //   ret = m.type.name == filtro && m.name.contains(pesquisa.text);
        // else
        //   ret = m.type.name == filtro ? true : false;

        if (filtro == "all" && pesquisa.text.isNotEmpty)
          ret = m.name.contains(pesquisa.text);

        return ret;
      }).toList();
    else if (item != null) retorno = item.itens;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(margin: EdgeInsets.all(5), child: pesquisa),
            itens == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                        children: List.generate(
                    isFiltro ? contFiltro : itemCont,
                    (index) {
                      return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetalhes(itens[index])));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 3,
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(itens[index]
                                                  .name
                                                  .toUpperCase()),
                                              CachedNetworkImage(
                                                imageUrl: itens[index]
                                                    .sprites
                                                    .defaultt,
                                                progressIndicatorBuilder:
                                                    (context, url, download) =>
                                                        CircularProgressIndicator(
                                                            value: download
                                                                .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.contain,
                                              )
                                            ]),
                                        Text(
                                            itens[index]
                                                .effectEntries
                                                .shortEffect,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600]),
                                            textAlign: TextAlign.center),
                                      ]))));
                    },
                  )))
          ],
        ));
  }
}
