import 'package:leadsdoit_project/domain/model/repository_item.dart';

import '../database/database.dart';
import 'interface/common_dao.dart';

class FavoriteDao implements FavoriteCommonDao<RepositoryItem> {
  final dbProvider = DatabaseProvider.dbProvider;

  @override
  Future<bool> add(RepositoryItem repositoryItem) async {
    final db = await dbProvider.database;
    int result = await db!.insert(favoriteTABLE, repositoryItem.toJson());

    return result == 1;
  }

  @override
  Future<void> addAll(List<RepositoryItem> list) async {
    final db = await dbProvider.database;
    await db!.transaction((txn) async {
      var batch = txn.batch();
      for (RepositoryItem repository in list) {
        List<Map<String, dynamic>> rawGoodItems = await txn
            .query(favoriteTABLE, where: 'id = ?', whereArgs: [repository.id]);
        if (rawGoodItems.isNotEmpty) {
          batch.update(favoriteTABLE, repository.toJson(),
              where: 'id = ?', whereArgs: [repository.id]);
        } else {
          batch.insert(favoriteTABLE, repository.toJson());
        }
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<RepositoryItem?> find(num id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> rawRepositoryItem =
        await db!.query(favoriteTABLE, where: 'id = ?', whereArgs: [id]);

    return rawRepositoryItem.isNotEmpty
        ? RepositoryItem.fromJson(rawRepositoryItem[0])
        : null;
  }

  @override
  Future<bool> remove(num id) async {
    final db = await dbProvider.database;
    int result =
        await db!.delete(favoriteTABLE, where: 'id = ?', whereArgs: [id]);
    return result == 1;
  }



  @override
  Future<bool> update(RepositoryItem repositoryItem) async {
    final db = await dbProvider.database;
    int result = await db!.update(favoriteTABLE, repositoryItem.toJson(),
        where: 'id = ?', whereArgs: [repositoryItem.id]);

    return result == 1;
  }


  @override
  Future<List<RepositoryItem>> getAll() async{
    final db = await dbProvider.database;
    List<Map<String, dynamic>> rawRepositoryItem=
        await db!.query(favoriteTABLE);
    List<RepositoryItem> repositories = rawRepositoryItem.isNotEmpty
        ? rawRepositoryItem.map((repos) => RepositoryItem.fromJson(repos)).toList()
        : [];

    return repositories;
  }

  @override
  Future<List<num>> getIds() async{
    final db = await dbProvider.database;
    List<Map<String, dynamic>> rawRepositoryItem=
        await db!.query(favoriteTABLE);
    List<num> repositories = rawRepositoryItem.isNotEmpty
        ? rawRepositoryItem.map((repos) => RepositoryItem.fromJson(repos).id??0).toList()
        : [];

    return repositories;
  }
}
