import 'package:poke_magic/beans/entidade.dart';
import 'package:poke_magic/util/sqlite.dart';
import 'package:poke_magic/util/tabela_favoritos.dart';

class Favorito extends Entidade {
  String nome;
  bool ativo = true;

  Favorito() : super(tabela: TabelaFavorito.NOME_TABELA);

  @override
  String toString() {
    return 'Favorito{id: $id, nome: $nome, ativo: $ativo}';
  }

  Favorito.fromMap(Map map) {
    id = map[TabelaFavorito.COL_ID];
    nome = map[TabelaFavorito.COL_NOME];
    ativo = map[TabelaFavorito.COL_ATIVO] == 1 ? ativo = true : ativo = false;
    tabela = TabelaFavorito.NOME_TABELA;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      TabelaFavorito.COL_ID: id,
      TabelaFavorito.COL_NOME: nome,
      TabelaFavorito.COL_ATIVO: ativo ? 1 : 0,
    };
    return map;
  }

  static Future<List<Favorito>> getAll() async {
    List listMap = await SqlUtil().getAll(TabelaFavorito.NOME_TABELA);
    List<Favorito> rotinas = List();
    for (Map m in listMap) {
      rotinas.add(Favorito.fromMap(m));
    }
    return rotinas;
  }

  static Future<Favorito> getId(int id) async {
    List listMapRotina = await SqlUtil().getId(TabelaFavorito.NOME_TABELA, id);
    print(listMapRotina);
    if (listMapRotina.length > 0) {
      Favorito rotina = Favorito.fromMap(listMapRotina.first);
      return rotina;
    }
    return null;
  }

  static Future<int> removeAll() async {
    return await SqlUtil().removeAll(TabelaFavorito.NOME_TABELA);
  }

  static Future<Favorito> getPorNome(String nome) async {
    List listMapUsuario = await SqlUtil()
        .getSearch(TabelaFavorito.NOME_TABELA, TabelaFavorito.COL_NOME, nome);
    if (listMapUsuario.length > 0) {
      Favorito favorito = Favorito.fromMap(listMapUsuario.first);
      return favorito;
    }
    return null;
  }
}
