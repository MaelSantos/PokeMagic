class TabelaTime {
  static const String NOME_TABELA = "Time";
  static const String COL_ID = "id";
  static const String COL_P1 = "p1";
  static const String COL_P2 = "p2";
  static const String COL_P3 = "p3";
  static const String COL_P4 = "p4";
  static const String COL_P5 = "p5";
  static const String COL_P6 = "p6";
  static const String COL_NOME = "nome";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_P1 INTEGER, "
      "$COL_P2 INTEGER, "
      "$COL_P3 INTEGER, "
      "$COL_P4 INTEGER, "
      "$COL_P5 INTEGER, "
      "$COL_P6 INTEGER, "
      "$COL_NOME TEXT "
      ");";
}
