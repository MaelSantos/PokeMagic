import 'package:flutter/material.dart';
import 'package:poke_magic/model/locations.dart';
import 'package:poke_magic/util/propaganda.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
import 'package:poke_magic/view/detalhes/location_detalhes.dart';

class LocationsPrincipal extends StatefulWidget {
  @override
  _LocationsPrincipalState createState() => _LocationsPrincipalState();
}

class _LocationsPrincipalState extends State<LocationsPrincipal> {
  Locations locations = Locations();

  List<Location> get location => _filtroPoke();
  String filtro;

  FieldCustom pesquisa;

  @override
  void initState() {
    filtro = "Kanto";
    pesquisa = FieldCustom("Search", iconData: Icons.search, onDigitar: (s) {
      setState(() {});
    });
    super.initState();
  }

  List<Location> _filtroPoke() {
    List<Location> retorno;

    try {
      if (locations != null)
        retorno = locations.locations.where((p) {
          String region = getRegion(p);
          bool ret = false;

          if (pesquisa.text.isNotEmpty) {
            ret = (p.location.name.contains(pesquisa.text) && region == filtro);
          } else if (region == filtro) ret = true;

          return ret;
        }).toList();
      else if (locations != null) retorno = locations.locations;
    } catch (e) {
      return retorno;
    }

    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _down(),
                    pesquisa,
                  ],
                )),
            _filtroPoke() == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                    children: _filtroPoke()
                        .map((e) => InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Propaganda.popUp();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LocationDetalhes(e)));
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 3,
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                              Text(
                                                  "${e.location.name.toUpperCase()} in ${getRegion(e)}"),
                                            ]),
                                      ],
                                    )))))
                        .toList(),
                  ))
          ]),
    );
  }

  String getRegion(Location l) {
    if (l.pokemonEncounters.isEmpty) return "";
    String region = l.pokemonEncounters[0].versionDetails.version.name;

    if (region == "firered" ||
        region == "red" ||
        region == "yellow" ||
        region == "blue" ||
        region == "leafgreen") return "Kanto";
    if (region == "soulsilver" || region == "heartgold") return "Johto";
    if (region == "emerald") return "Hoenn";
    if (region == "platinum" || region == "diamond" || region == "pearl")
      return "Sinnoh";
    if (region == "white" || region == "white-2") return "Unova";
    if (region == "y") return "Kalos";
    // if (region == "platinum" || region == "diamond") return "Alola";

    return region;
  }

  DropdownButton _down() => DropdownButton<String>(
        items: [
          DropdownMenuItem(value: "Kanto", child: Text("Kanto")),
          DropdownMenuItem(value: "Johto", child: Text("Johto")),
          DropdownMenuItem(value: "Hoenn", child: Text("Hoenn")),
          DropdownMenuItem(value: "Sinnoh", child: Text("Sinnoh")),
          DropdownMenuItem(value: "Unova", child: Text("Unova")),
          DropdownMenuItem(value: "Kalos", child: Text("Kalos")),
          // DropdownMenuItem(value: "", child: Text("Null")),
        ],
        onChanged: (p) {
          setState(() {
            filtro = p;
          });
        },
        value: filtro,
      );
}
