import 'package:flutter/material.dart';
import 'package:poke_magic/model/types.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/detalhes/type_detalhes.dart';
import 'package:poke_magic/util/propaganda.dart';

class TypePricipal extends StatefulWidget {
  @override
  _TypePricipalState createState() => _TypePricipalState();
}

class _TypePricipalState extends State<TypePricipal> {
  Types get type => Types();

  List<Type> get types => _filtroPoke(); //type.types;//;
  int typesCont = 18; //total de pokemons
  bool isFiltro;
  int get contFiltro => types.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    isFiltro = false;
    pesquisa = FieldCustom("Search", iconData: Icons.search, onDigitar: (s) {
      setState(() {
        if (s.isEmpty)
          isFiltro = false;
        else
          isFiltro = true;
      });
    });
    super.initState();
  }

  List<Type> _filtroPoke() {
    List<Type> retorno;

    if (type != null && isFiltro)
      retorno = type.types.where((m) {
        bool ret = true;

        if (pesquisa.text.isNotEmpty) ret = m.name.contains(pesquisa.text);

        return ret;
      }).toList();
    else if (type != null) retorno = type.types;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    pesquisa,
                  ],
                )),
            types == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                        children: List.generate(
                    isFiltro ? contFiltro : typesCont,
                    (index) {
                      return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TypeDetalhes(types[index])));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          containerColor(
                                            types[index].name.toUpperCase(),
                                            formatColorExist(types[index].name),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))));
                    },
                  )))
          ],
        ));
  }
}
