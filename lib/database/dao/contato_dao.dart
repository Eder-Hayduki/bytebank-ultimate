import 'package:bytebank_ultimate/models/contato.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContatoDao {
  static const String _nomeTabela = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numero_conta = 'numero_conta';

  static const String tableSQL = 'CREATE TABLE $_nomeTabela('
      '$_id INTEGER PRIMARY KEY,'
      '$_nome TEXT,'
      '$_numero_conta INTEGER)';

  Future<int> salvar(Contato contato) async {
    final Database db = await getDatabase();

    Map<String, dynamic> contatoMap = _toMap(contato);

    return db.insert(_nomeTabela, contatoMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contatoMap = Map();
    //contatoMap[_id] = contato.id;
    contatoMap[_nome] = contato.nome;
    contatoMap[_numero_conta] = contato.numeroConta;
    return contatoMap;
  }

  Future<List<Contato>> buscar() async {
    final Database db = await getDatabase();
    List<Contato> contatos = await _toList(db);
    return contatos;
  }

  Future<int> alterar(Contato contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);

    return db.update(
      _nomeTabela,
      contatoMap,
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> apagar(int id) async {
    final Database db = await getDatabase();

    return db.delete(
      _nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<List<Contato>> _toList(Database db) async {
    final List<Contato> contatos = [];
    for (Map<String, dynamic> linha in await db.query(_nomeTabela)) {
      final Contato contato = Contato(
        linha[_id],
        linha[_nome],
        linha[_numero_conta],
      );
      contatos.add(contato);
    }
    return contatos;
  }
}
