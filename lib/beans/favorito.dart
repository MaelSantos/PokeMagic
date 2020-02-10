import 'package:poke_magic/util/sqlite.dart';
import 'package:poke_magic/util/tabela_favoritos.dart';
import 'package:sqflite/sqlite_api.dart';

class Favorito {
  int id;
  String nome;
  bool ativo = true;

  Favorito();

  @override
  String toString() {
    return 'Favorito{id: $id, nome: $nome, ativo: $ativo}';
  }

  Favorito.fromMapWeb(Map map) {
    id = map["id"];
    nome = map["nome"];
    ativo = map["ativo"];
  }

  Favorito.fromMapSqLite(Map map) {
    id = map[TabelaFavorito.COL_ID];
    nome = map[TabelaFavorito.COL_NOME];
    ativo = map[TabelaFavorito.COL_ATIVO] == 1 ? ativo = true : ativo = false;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      TabelaFavorito.COL_ID: id,
      TabelaFavorito.COL_NOME: nome,
      TabelaFavorito.COL_ATIVO: ativo,
    };
    return map;
  }

  Future<int> save() async {
    Database dataBase = await SqlUtil().db;
    int valor = await dataBase.insert(TabelaFavorito.NOME_TABELA, toMap());
    print("VALOR $valor");
    return valor;
  }

  Future<Favorito> update() async {
    Database dataBase = await SqlUtil().db;
    List listMapUsuario =
        await dataBase.rawQuery(TabelaFavorito.update(ativo, id));
    if (listMapUsuario.length > 0) {
      Favorito favorito = Favorito.fromMapSqLite(listMapUsuario.first);
      return favorito;
    }
    return null;
  }

  Future remove() async {
    Database dataBase = await SqlUtil().db;
    await dataBase.rawDelete(TabelaFavorito.removeNome(nome));
  }

  static Future<List<Favorito>> getAll() async {
    Database dataBase = await SqlUtil().db;
    List listMap = await dataBase.rawQuery(TabelaFavorito.getAll());
    List<Favorito> favoritos = List();
    for (Map m in listMap) {
      favoritos.add(Favorito.fromMapSqLite(m));
    }
    return favoritos;
  }

  static Future<Favorito> getAtivo() async {
    Database dataBase = await SqlUtil().db;
    List listMapUsuario =
        await dataBase.rawQuery(TabelaFavorito.getAllPorAtivo(true));
    if (listMapUsuario.length > 0) {
      Favorito favorito = Favorito.fromMapSqLite(listMapUsuario.first);
      return favorito;
    }
    return null;
  }

  static Future<Favorito> getPorNome(String nome) async {
    Database dataBase = await SqlUtil().db;
    List listMapUsuario =
        await dataBase.rawQuery(TabelaFavorito.getPorNome(nome));
    if (listMapUsuario.length > 0) {
      Favorito favorito = Favorito.fromMapSqLite(listMapUsuario.first);
      return favorito;
    }
    return null;
  }

  static Future removeId(int id) async {
    Database dataBase = await SqlUtil().db;
    await dataBase.rawDelete(TabelaFavorito.removeId(id));
  }

  static Future removeAll() async {
    Database dataBase = await SqlUtil().db;
    await dataBase.rawDelete(TabelaFavorito.removeAll());
  }
}
