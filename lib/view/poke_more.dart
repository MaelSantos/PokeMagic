import 'package:flutter/material.dart';
import 'package:poke_magic/model/pokedex.dart';
import 'package:poke_magic/model/types.dart';
import 'package:poke_magic/view/detalhes/type_detalhes.dart';

class PokeMore extends StatelessWidget {
  final Pokemon pokemon;
  Type type;

  PokeMore(this.pokemon) {
    type = Types().toType(pokemon.types[0].type.name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TypeDetalhes(type),
      ),
    );
  }
}
