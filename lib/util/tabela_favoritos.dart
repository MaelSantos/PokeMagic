class TabelaFavorito {
  static const String NOME_TABELA = "favorito";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_ATIVO = "ativo";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_NOME TEXT, "
      "$COL_ATIVO BOOL);";

  static String getAllPorAtivo(bool ativo) {
    int valor;
    ativo ? valor = 1 : valor = 0;
    return "SELECT * FROM $NOME_TABELA where $COL_ATIVO='$valor'";
  }

  static String getPorNome(String nome) {
    return "SELECT * FROM $NOME_TABELA where $COL_NOME='$nome'";
  }

  static String getPorId(int id) {
    return "SELECT * FROM $NOME_TABELA where id='$id'";
  }

  static String update(bool ativo, int id) {
    int valor;
    ativo ? valor = 1 : valor = 0;
    return "UPDATE $NOME_TABELA SET ativo=$valor where id=$id";
  }

  static String getAll() {
    return "SELECT * FROM $NOME_TABELA";
  }

  static String removeId(int id) {
    return "DELETE FROM $NOME_TABELA where $COL_ID='$id'";
  }

  static String removeNome(String nome) {
    return "DELETE FROM $NOME_TABELA where $COL_NOME='$nome'";
  }

  static String removeAll() {
    return "DELETE FROM $NOME_TABELA ";
  }
}
