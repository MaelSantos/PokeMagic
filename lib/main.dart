import 'package:flutter/material.dart';
import 'package:poke_magic/view/componentes/field_custom.dart';
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
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    title: TextStyle(fontSize: 18, fontFamily: "FredokaOne"))),
            textTheme: TextTheme(
                // button: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // headline: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // display1: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // overline: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // caption: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // title: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                // subtitle: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                subhead: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                body1: TextStyle(fontSize: 14, fontFamily: "FredokaOne"),
                body2: TextStyle(fontSize: 14, fontFamily: "FredokaOne"))),
        home: Scaffold(
          appBar: AppBar(
            title: Text("PokéMagic"),
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
                  title:
                      Text("Pokémons", style: TextStyle(color: Colors.black)),
                  trailing: Text("807"),
                  // selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(thickness: 1),
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
