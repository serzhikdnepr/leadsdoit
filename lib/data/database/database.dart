import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const favoriteTABLE = 'favoriteRepositories';
const historyTABLE = 'historyRepositories';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "leadsdoit.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $favoriteTABLE ("
        "id                    INTEGER primary key, "
        "node_id               TEXT, "
        "name                  TEXT, "
        "full_name             TEXT, "
        "html_url              TEXT, "
        "description           TEXT, "
        "url                   TEXT, "
        "forks                 INTEGER, "
        "open_issues           INTEGER, "
        "watchers              INTEGER, "
        "default_branch        TEXT, "
        "score                 INTEGER "
        ")");
    await database.execute("CREATE TABLE $historyTABLE ("
        "id                    INTEGER primary key, "
        "node_id               TEXT, "
        "name                  TEXT, "
        "full_name             TEXT, "
        "html_url              TEXT, "
        "description           TEXT, "
        "url                   TEXT, "
        "forks                 INTEGER, "
        "open_issues           INTEGER, "
        "watchers              INTEGER, "
        "date_added            INTEGER, "
        "default_branch        TEXT, "
        "score                 INTEGER "
        ")");
  }
}
