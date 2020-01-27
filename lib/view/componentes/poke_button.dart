import 'package:flutter/material.dart';

class PokeButton extends StatelessWidget {
  final double altura;
  final bool isEscondido;
  final String conteudo;
  final Color cor;
  void Function(bool) onSelecionado;

  PokeButton(this.conteudo,
      {this.isEscondido = false,
      this.altura = 35,
      this.cor = Colors.cyan,
      this.onSelecionado}) {
    onSelecionado ??= selecionar;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onSelected: onSelecionado,
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isEscondido
              ? Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 13),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20))),
                  child: Text("hidden", style: TextStyle(color: Colors.white)),
                )
              : Container(),
          isEscondido
              ? VerticalDivider(thickness: 2, width: 2, color: Colors.black45)
              : Container(),
          Container(
            alignment: isEscondido ? Alignment.centerRight : Alignment.center,
            padding: EdgeInsets.only(
                top: 5, bottom: 5, right: 13, left: isEscondido ? 5 : 13),
            decoration: BoxDecoration(
                color: isEscondido ? Colors.cyan[400] : cor,
                borderRadius: isEscondido
                    ? BorderRadius.horizontal(right: Radius.circular(20))
                    : BorderRadius.circular(20)),
            child: Text(conteudo, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void selecionar(bool b) {}
}
