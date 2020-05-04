import 'package:poke_magic/beans/entidade.dart';
import 'package:poke_magic/util/sqlite.dart';
import 'package:poke_magic/util/tabela_time.dart';

class Time extends Entidade {
  int id;
  String nome = "Team";
  int p1, p2, p3, p4, p5, p6;
  List<int> get indexs => [p1, p2, p3, p4, p5, p6];
  void setIndexs(List<int> indexs) {
    p1 = indexs[0];
    p2 = indexs[1];
    p3 = indexs[2];
    p4 = indexs[3];
    p5 = indexs[4];
    p6 = indexs[5];
  }
  // String pn1, pn2, pn3, pn4, pn5, pn6;

  Time() : super(tabela: TabelaTime.NOME_TABELA);

  Time.fromMap(Map map) {
    id = map[TabelaTime.COL_ID];
    nome = map[TabelaTime.COL_NOME];
    p1 = map[TabelaTime.COL_P1];
    p2 = map[TabelaTime.COL_P2];
    p3 = map[TabelaTime.COL_P3];
    p4 = map[TabelaTime.COL_P4];
    p5 = map[TabelaTime.COL_P5];
    p6 = map[TabelaTime.COL_P6];
    tabela = TabelaTime.NOME_TABELA;
  }

  @override
  Map toMap() {
    Map<String, dynamic> map = {
      TabelaTime.COL_ID: id,
      TabelaTime.COL_NOME: nome,
      TabelaTime.COL_P1: p1,
      TabelaTime.COL_P2: p2,
      TabelaTime.COL_P3: p3,
      TabelaTime.COL_P4: p4,
      TabelaTime.COL_P5: p5,
      TabelaTime.COL_P6: p6,
    };
    return map;
  }

  static Future<List<Time>> getAll() async {
    List listMap = await SqlUtil().getAll(TabelaTime.NOME_TABELA);
    List<Time> times = List();
    for (Map m in listMap) {
      times.add(Time.fromMap(m));
    }
    return times;
  }

  static Future<Time> getId(int id) async {
    List listMapTimes = await SqlUtil().getId(TabelaTime.NOME_TABELA, id);
    print(listMapTimes);
    if (listMapTimes.length > 0) {
      Time rotina = Time.fromMap(listMapTimes.first);
      return rotina;
    }
    return null;
  }

  static Future<int> removeAll() async {
    return await SqlUtil().removeAll(TabelaTime.NOME_TABELA);
  }

  static Future<Time> getPorNome(String nome) async {
    List listMapTimes = await SqlUtil()
        .getSearch(TabelaTime.NOME_TABELA, TabelaTime.COL_NOME, nome);
    if (listMapTimes.length > 0) {
      Time favorito = Time.fromMap(listMapTimes.first);
      return favorito;
    }
    return null;
  }
}
