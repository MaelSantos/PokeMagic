import 'package:flutter/material.dart';

class FieldCustom extends StatelessWidget {
  TextEditingController controlador;
  String _texto;
  bool erro, isPassword;
  String mensagemErro;
  Icon icone;

  void Function(String) onDigitar, onFinalizar;

  String get text => controlador.text.trim();

  FieldCustom(this._texto,
      {this.onDigitar,
      this.onFinalizar,
      this.isPassword = false,
      this.mensagemErro = "Dados invalidos",
      IconData iconData = Icons.person}) {
    icone = Icon(iconData, color: Colors.cyan);
    erro = false;
    controlador = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return component(context);
  }

  String validar(String value) {
    value = value.trim();
    if (erro) {
      erro = false;
      return mensagemErro;
    } else if (value.isEmpty) {
      return "Campo Obrigatório";
    }
    return null;
  }

  Widget component(BuildContext context) {
    return Container(
        width: (_texto.length * 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                child: TextFormField(
                  onChanged: onDigitar,
                  onFieldSubmitted: onDigitar,
                  controller: controlador,
                  validator: validar,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none, icon: icone, hintText: _texto),
                ),
              )
            ]));
  }
}
