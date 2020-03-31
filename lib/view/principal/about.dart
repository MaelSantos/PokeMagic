import 'package:flutter/material.dart';
import 'package:poke_magic/util/format.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:poke_magic/view/principal/changelog.dart';
import 'package:poke_magic/view/principal/privacy_policies.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Column(
                children: [
                  Image.asset("assets/icon.png", height: 150),
                  SizedBox(height: 10),
                  Text("PokéMagic 1.0.2", textAlign: TextAlign.center)
                ],
              )),
              SizedBox(height: 10),
              gerarContainer(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Developer: Mael Santos"),
                  Row(
                    children: [
                      Text("Contact: "),
                      InkWell(
                          child: Text("maelsantos777@gmail.com",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          onTap: () =>
                              launch("mailto: maelsantos777@gmail.com"))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    Text("Data extracted from: "),
                    InkWell(
                        child: Text("PokéAPI",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline)),
                        onTap: () => launch('https://pokeapi.co/'))
                  ]),
                ],
              )),
              gerarContainer(
                  child: Text(
                      "All images were taken from public online databases "
                      "and encyclopedias of Pokemon fandons created by fans.")),
              gerarContainer(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                        child: Text("General Warning",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    SizedBox(height: 10),
                    Text(
                        "PokéMagic is an unofficial application, made by fans, is free and is NOT affiliated, "
                        "endorsed or supported by Nintendo, GAME FREAK or The Pokémon company in any way. "
                        "Some images used in this application are protected by copyright and are supported for fair use. "
                        "Pokémon and Pokémon character names are trademarks of Nintendo. "
                        "There is no intention to infringe copyright."),
                    SizedBox(height: 10),
                    Text("Pokémon © 2002-2020 Pokémon."),
                    Text("© 1995-2020 Nintendo/Creatures Inc./GAME FREAK inc."),
                  ])),
              gerarContainer(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                        "By using PokéMagic, you agree that you have read the Privacy Policy and have agreed to its terms. "
                        "Read again by tapping the button below"),
                    SizedBox(height: 10),
                    Center(
                      child: PokeButton("Privacy Policies", onSelecionado: (b) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicies()));
                      }),
                    ),
                  ])),
              gerarContainer(
                  child: PokeButton(
                "Changelog",
                onSelecionado: (b) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Changelog()));
                },
              )),
            ],
          ),
        ));
  }
}
