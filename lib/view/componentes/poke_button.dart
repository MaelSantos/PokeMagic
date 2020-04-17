import 'package:flutter/material.dart';

class PokeButton extends StatefulWidget {
  final double altura;
  final bool isEscondido;
  final String conteudo;
  void Function(bool) onSelecionado;
  Color cor;
  bool selecionado;
  bool selecionavel;

  PokeButtonState _pokeButtonState;

  PokeButton(this.conteudo,
      {this.isEscondido = false,
      this.altura = 35,
      this.cor = Colors.cyan,
      this.onSelecionado,
      this.selecionado = false,
      this.selecionavel = false}) {
    _pokeButtonState = PokeButtonState(conteudo,
        isEscondido: isEscondido,
        altura: altura,
        cor: cor,
        onSelecionado: onSelecionado,
        selecionavel: selecionavel,
        selecionado: selecionado);
  }

  @override
  PokeButtonState createState() => _pokeButtonState;

  void selecionar(bool b) {
    _pokeButtonState.selecionar(b);
  }
}

class PokeButtonState extends State<PokeButton> {
  final double altura;
  final bool isEscondido;
  final String conteudo;
  void Function(bool) onSelecionado;
  Color cor;
  Color corAnterior;
  bool selecionado;
  bool selecionavel;

  PokeButtonState(
    this.conteudo, {
    this.isEscondido = false,
    this.altura = 35,
    this.cor = Colors.cyan,
    this.onSelecionado,
    this.selecionado = false,
    this.selecionavel = false,
  }) {
    onSelecionado ??= selecionar;
    corAnterior = cor;
  }

  @override
  void initState() {
    super.initState();
    if (selecionado && selecionavel) selecionar(true);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        child: FilterChip(
          labelPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          selected: (selecionado && selecionavel),
          onSelected: onSelecionado,
          showCheckmark: false,
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isEscondido
                  ? Container(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 5, left: 13),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20))),
                      child:
                          Text("hidden", style: TextStyle(color: Colors.white)),
                    )
                  : Container(),
              isEscondido
                  ? VerticalDivider(
                      thickness: 2, width: 2, color: Colors.black45)
                  : Container(),
              Container(
                alignment:
                    isEscondido ? Alignment.centerRight : Alignment.center,
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
        ));
  }

  void selecionar(bool b) {
    if (selecionavel) {
      selecionado = b;
      if (b)
        cor = Colors.cyan[900];
      else
        cor = corAnterior;
    }
    setState(() {});
  }
}
