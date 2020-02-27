import 'package:flutter/material.dart';
import 'package:poke_magic/beans/configuracao.dart';
import 'package:poke_magic/view/componentes/poke_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class AccpetPolicies extends StatefulWidget {
  @override
  _AccpetPoliciesState createState() => _AccpetPoliciesState();
}

class _AccpetPoliciesState extends State<AccpetPolicies> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policies")),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.9,
            margin: EdgeInsets.all(10),
            child: WebView(
              initialUrl:
                  "https://pokemagicpoliticasprivacidade.wordpress.com/",
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30),
              child:
                  PokeButton("Accept and Continue", onSelecionado: (b) async {
                Configuracao configuracao = await Configuracao.getId(1);
                configuracao.policies = true;
                configuracao.update();
                Navigator.pushReplacementNamed(context, '/Menu');
              }))
        ],
      ),
    );
  }
}
