class TabelaConfiguracao {
  static const String NOME_TABELA = "Configuracao";
  static const String COL_ID = "id";
  static const String COL_POLICIES = "policies";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_POLICIES BOOL "
      ");";
}
