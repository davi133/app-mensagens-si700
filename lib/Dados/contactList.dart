import 'dart:developer';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/contato.dart';

class ContactDataProvider {
  static const String tableName = "contacts";
  static const String chave = "id";
  static const String apelido = "apelido";
  static const String numero = "numero";

  static ContactDataProvider helper = ContactDataProvider._createInstance();
  static Database? _database;
  ContactDataProvider._createInstance();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("unitalk.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}$filepath";
    //await _deleteDatabase();//ONLY UNCOMMENT THIS TO RESET THE DATABASE

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  _createDb(Database db, int newVersion) async {
    //print("criando DB =======================================================");
    db.execute("""
       CREATE TABLE $tableName (
           $chave INTEGER PRIMARY KEY AUTOINCREMENT,
           $apelido TEXT,
           $numero INTEGER
          );
    """);

    db.insert(tableName,
        Contato("Felipe Araujo Santos Pinto", 169401, id: 0).toMap());
    db.insert(
        tableName, Contato("Davi Pereira Bergamin", 169753, id: 1).toMap());
    db.insert(tableName, Contato("Joao", 1003, id: 2).toMap());
    db.insert(tableName, Contato("Pedro", 1004, id: 3).toMap());
    db.insert(tableName, Contato("Ulisses", 1010).toMap());
  }

  Future<void> _deleteDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}unitalk.db";
    databaseFactory.deleteDatabase(path);
  }

  Future<List<Contato>> getContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    Database db = await database;
    List<Map<String, Object?>> noteMapList =
        await db.rawQuery("SELECT * FROM $tableName;");
    List<Contato> contactList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      contactList.add(Contato.fromMap(noteMapList[i]));
    }
    return contactList;
  }

  Future<int> addContato(Contato cont) async {
    Database? db = await database;
    int res = await db.insert(tableName, cont.toMap());
    cont.id = res;
    notify("c", res, cont);
    return res;
  }

  Future<Contato?> getByNumber(int number) async {
    Database db = await database;
    List<Map<String, Object?>> noteMapList =
        await db.rawQuery("SELECT * FROM $tableName where $numero=$number;");
    Contato cont = Contato.fromMap(noteMapList[0]);

    //TODO: is it working? maybe, I will not test it today
    return cont;
  }

  Future<int> editContato(Contato novo) async {
    Database db = await database;
    int res = await db.update(tableName, novo.toMap(),
        where: "$chave = ?", whereArgs: [novo.id]);

    notify("u", res, novo);
    return res;
  }

  Future<int> removeContato(Contato cont) async {
    Database db = await database;
    int res =
        await db.delete(tableName, where: "$chave=?", whereArgs: [cont.id]);
    notify("d", res, cont);
    return res;
  }

  Future close() async {
    print("closing db");
    final db = await helper.database;
    db.close();
  }

  //##########
  //notificando os dependentes
  //##########

  notify(String operation, int res, Contato? cont) async {
    //c = add contato
    //u = edit contato
    //d = delete contato
    if (!_controller!.isClosed) _controller?.sink.add([operation, res, cont]);
  }

  Stream get stream {
    _controller ??= StreamController.broadcast();
    return _controller!.stream;
  }

  dispose() {
    if (_controller != null) {
      if (!_controller!.hasListener) {
        print(
            "closgin stream===============================================================================");
        _controller!.close();
        _controller = null;
      }
    }
  }

  static StreamController? _controller;
}

var contactListDeprecated = [
  //done
  Contato("Felipe Araujo Santos Pinto", 169401),
  Contato("Davi Pereira Bergamin", 169753),
  Contato("Joao", 1003),
  Contato("Pedro", 1004),
  //Contato("Robson", 1005),
  Contato("Ulisses", 1010)
];

Contato? getByNumber(int number) {
  //done
  for (int i = 0; i < contactListDeprecated.length; i++) {
    if (number == contactListDeprecated[i].numero) {
      return contactListDeprecated[i];
    }
  }
  return null;
}
