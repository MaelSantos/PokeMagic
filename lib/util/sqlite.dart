import 'package:path/path.dart';
import 'package:poke_magic/util/tabela_configuracao.dart';
import 'package:poke_magic/util/tabela_favoritos.dart';
import 'package:poke_magic/util/tabela_time.dart';
import 'package:sqflite/sqflite.dart';

class SqlUtil {
  static const String NOME_BASE_DADOS = "pokemon.db";
  static final SqlUtil _instance = SqlUtil.internal();

  factory SqlUtil() => _instance;

  SqlUtil.internal();

  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDd();
    }
    return _db;
  }

  Future<Database> _initDd() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, NOME_BASE_DADOS);

    return await openDatabase(path,
        version: 1, onCreate: createTable, onUpgrade: updateTable);
  }

  void createTable(Database db, int newVersion) async {
    await db.execute(TabelaFavorito.createTable);
    await db.execute(TabelaConfiguracao.createTable);
    await db.execute(TabelaTime.createTable);
  }

  void updateTable(Database db, int oldVersion, int newVersion) async {
//    await db.execute(TabelaUsuario.createTable);
  }

  Future<int> save(String tabela, Map<String, dynamic> map) async {
    Database dataBase = await db;
    return await dataBase.insert(tabela, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(String tabela, Map<String, dynamic> map, int id) async {
    Database dataBase = await db;
    return dataBase.update(tabela, map, where: "id = ?", whereArgs: [id]);
  }

  Future remove(String tabela, int id) async {
    Database dataBase = await db;
    await dataBase.delete(tabela, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getId(String tabela, int id) async {
    Database dataBase = await db;
    return dataBase.query(tabela, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getSearch(
      String tabela, String colunm, dynamic id) async {
    Database dataBase = await db;
    return dataBase.query(tabela, where: "$colunm = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAll(String tabela) async {
    Database dataBase = await db;
    return dataBase.query(tabela);
  }

  Future<int> removeAll(String tabela) async {
    Database dataBase = await db;
    return dataBase.delete(tabela);
  }
}
