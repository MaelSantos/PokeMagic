import 'package:poke_magic/beans/entidade.dart';
import 'package:poke_magic/util/sqlite.dart';
import 'package:poke_magic/util/tabela_configuracao.dart';

class Configuracao extends Entidade {
  int id;
  bool policies = false;

  Configuracao() : super(tabela: TabelaConfiguracao.NOME_TABELA);

  @override
  String toString() {
    return 'Configuracao{id: $id, policies: $policies}';
  }

  Configuracao.fromMap(Map map) {
    id = map[TabelaConfiguracao.COL_ID];
    policies = map[TabelaConfiguracao.COL_POLICIES] == 1
        ? policies = true
        : policies = false;
    tabela = TabelaConfiguracao.NOME_TABELA;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      TabelaConfiguracao.COL_ID: id,
      TabelaConfiguracao.COL_POLICIES: policies ? 1 : 0,
    };
    return map;
  }

  static Future<List<Configuracao>> getAll() async {
    List listMap = await SqlUtil().getAll(TabelaConfiguracao.NOME_TABELA);
    List<Configuracao> rotinas = List();
    for (Map m in listMap) {
      rotinas.add(Configuracao.fromMap(m));
    }
    return rotinas;
  }

  static Future<Configuracao> getId(int id) async {
    List listMapRotina =
        await SqlUtil().getId(TabelaConfiguracao.NOME_TABELA, id);
    print(listMapRotina);
    if (listMapRotina.length > 0) {
      Configuracao rotina = Configuracao.fromMap(listMapRotina.first);
      return rotina;
    }
    return null;
  }

  static Future<int> removeAll() async {
    return await SqlUtil().removeAll(TabelaConfiguracao.NOME_TABELA);
  }
}
