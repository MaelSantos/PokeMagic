import 'package:poke_magic/model/abilitys.dart';
import 'package:flutter/material.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/detalhes/ability_detalhes.dart';
import 'package:poke_magic/util/propaganda.dart';

class AbilitiesPricipal extends StatefulWidget {
  @override
  _PokeAbilitiesState createState() => _PokeAbilitiesState();
}

class _PokeAbilitiesState extends State<AbilitiesPricipal> {
  Abilitys get ability => Abilitys();

  List<Ability> get abilitys => _filtroPoke(); //ability.abilitys;//;
  int abilityCont = 233; //total de pokemons
  bool isFiltro;
  String filtro;
  int get contFiltro => abilitys.length;

  FieldCustom pesquisa;

  @override
  void initState() {
    isFiltro = false;
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

  List<Ability> _filtroPoke() {
    List<Ability> retorno;

    if (ability != null && isFiltro)
      retorno = ability.abilitys.where((m) {
        bool ret = true;
        if (pesquisa.text.isNotEmpty) ret = m.name.contains(pesquisa.text);
        return ret;
      }).toList();
    else if (ability != null) retorno = ability.abilitys;
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    pesquisa,
                  ],
                )),
            abilitys == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                        children: List.generate(
                    isFiltro ? contFiltro : abilityCont,
                    (index) {
                      return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Propaganda.popUp();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AbilityDetalhes(abilitys[index])));
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
                                      Text(abilitys[index].name.toUpperCase()),
                                      Text(
                                          abilitys[index]
                                              .effectEntries
                                              .shortEffect,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                          textAlign: TextAlign.center)
                                    ],
                                  ))));
                    },
                  )))
          ],
        ));
  }
}
