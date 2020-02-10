import 'package:path/path.dart';
import 'package:poke_magic/util/tabela_favoritos.dart';
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
        version: 1, onCreate: create, onUpgrade: update);
  }

  void create(Database db, int newVersion) async {
    await db.execute(TabelaFavorito.createTable);
  }

  void update(Database db, int oldVersion, int newVersion) async {
//    await db.execute(TabelaUsuario.createTable);
  }
}
