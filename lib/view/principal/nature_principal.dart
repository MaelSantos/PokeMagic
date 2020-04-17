import 'package:poke_magic/model/comum.dart';
import 'package:poke_magic/model/natures.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';

class NaturePricipal extends StatefulWidget {
  @override
  _NaturePricipalState createState() => _NaturePricipalState();
}

class _NaturePricipalState extends State<NaturePricipal> {
  Natures get natures => Natures();

  List<Nature> get nature => _filtroPoke();
  int get natureCont => nature.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    pesquisa = FieldCustom("Search", iconData: Icons.search);
    super.initState();
  }

  List<Nature> _filtroPoke() {
    List<Nature> retorno;

    if (natures != null && pesquisa.text.trim().isNotEmpty)
      retorno = natures.natures.where((m) {
        return m.name.contains(pesquisa.text);
      }).toList();
    else if (natures != null) retorno = natures.natures;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [pesquisa]),
                  ],
                )),
            nature == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                        children: nature
                            .map((n) => InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {},
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 3,
                                    child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child:  
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(n.name.toUpperCase()),
                                            Divider(thickness: 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(children: [
                                                  text(n.increasedStat,
                                                      icon: Icons.add),
                                                  text(n.likesFlavor,
                                                      texto: "Likes Flavor")
                                                ]),
                                                VerticalDivider(thickness: 2),
                                                Column(children: [
                                                  text(n.decreasedStat,
                                                      icon: Icons.remove),
                                                  text(n.hatesFlavor,
                                                      texto: "Hates Flavor")
                                                ]),
                                              ],
                                            ),
                                          ],
                                        )))))
                            .toList()))
          ],
        ));
  }

  Widget text(Comum comum, {IconData icon, String texto}) {
    return Container(
      child: comum != null
          ? Row(children: [
              Icon(icon),
              texto != null
                  ? Text(texto + ": " + comum.name.toUpperCase())
                  : Text(comum.name.toUpperCase())
            ])
          : Text("-"),
    );
  }
}
