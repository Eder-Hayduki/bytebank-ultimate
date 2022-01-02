import 'package:bytebank_ultimate/database/dao/contato_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Criar banco. Função para criar o banco de dados;

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContatoDao.tableSQL);
    },
    version: 1,
//        onDowngrade: onDatabaseDowngradeDelete,
  );
}
