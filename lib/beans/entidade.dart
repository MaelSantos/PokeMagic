import 'package:poke_magic/util/sqlite.dart';

abstract class Entidade {
  int id;
  String tabela;

  Entidade({this.tabela});

  void save() {
    SqlUtil().save(tabela, toMap());
  }

  void update() {
    SqlUtil().update(tabela, toMap(), id);
  }

  void remove() {
    SqlUtil().remove(tabela, id);
  }

  Map toMap();
}
