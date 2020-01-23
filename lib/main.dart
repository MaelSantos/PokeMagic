import 'package:flutter/material.dart';
import 'package:poke_magic/view/poke_principal.dart';

void main() async {
  runApp(PokeMagic());
}

class PokeMagic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PokéMagic",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
                body1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                body2: TextStyle(
                  // fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  // decorationColor: Colors.white,
                ))),
        home: Scaffold(
          appBar: AppBar(
            // actions: <Widget>[Text("teste")],
            title: Text("PokéMagic", style: TextStyle(fontSize: 20)),
            backgroundColor: Colors.cyan,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text("PokéMagic"),
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Pokémons",
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text("807"),
                  // selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  thickness: 1,
                ),
                ListTile(
                  title: Text("Habilidades"),
                  trailing: Text("-"),
                  enabled: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // floatingActionButton:
          //     FloatingActionButton(onPressed: () {
          //       setState(() {
          //         carregarDados();
          //       });
          //     }, child: Icon(Icons.refresh)),
          body: PokePricipal(),
        ));
  }
}
