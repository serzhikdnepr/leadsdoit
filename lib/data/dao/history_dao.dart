import 'package:leadsdoit_project/core/constants.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';

import '../database/database.dart';
import 'interface/common_dao.dart';

class HistoryDao implements HistoryCommonDao<RepositoryItem> {
  final dbProvider = DatabaseProvider.dbProvider;

  @override
  Future<bool> add(RepositoryItem repositoryItem) async {
    final db = await dbProvider.database;
    int result = await db!.insert(historyTABLE, repositoryItem.toJson());

    return result == 1;
  }

  @override
  Future<void> addAll(List<RepositoryItem> list) async {
    final db = await dbProvider.database;
    await db!.transaction((txn) async {
      var batch = txn.batch();
      for (RepositoryItem repository in list) {
        List<Map<String, dynamic>> rawGoodItems = await txn
            .query(historyTABLE, where: 'id = ?', whereArgs: [repository.id]);
        repository.dateAdded = DateTime.now().millisecondsSinceEpoch;
        if (rawGoodItems.isNotEmpty) {
          batch.update(historyTABLE, repository.toJson(),
              where: 'id = ?', whereArgs: [repository.id]);
        } else {
          batch.insert(historyTABLE, repository.toJson());
        }
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<RepositoryItem?> find(num id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> rawRepositoryItem =
        await db!.query(historyTABLE, where: 'id = ?', whereArgs: [id]);

    return rawRepositoryItem.isNotEmpty
        ? RepositoryItem.fromJson(rawRepositoryItem[0])
        : null;
  }

  @override
  Future<bool> remove(num id) async {
    final db = await dbProvider.database;
    int result =
        await db!.delete(historyTABLE, where: 'id = ?', whereArgs: [id]);
    return result == 1;
  }

  @override
  Future<bool> update(RepositoryItem repositoryItem) async {
    final db = await dbProvider.database;
    int result = await db!.update(historyTABLE, repositoryItem.toJson(),
        where: 'id = ?', whereArgs: [repositoryItem.id]);

    return result == 1;
  }

  @override
  Future<List<RepositoryItem>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> rawRepositoryItem =
        await db!.query(historyTABLE, orderBy: 'date_added DESC');
    List<RepositoryItem> repositories = rawRepositoryItem.isNotEmpty
        ? rawRepositoryItem
            .map((repos) => RepositoryItem.fromJson(repos))
            .toList()
        : [];

    /* Temporary solution for cleaning the database */
    if (repositories.length > Constants.maxHistoryRepository) {
      var repos = repositories.sublist(Constants.maxHistoryRepository+1, repositories.length-1);
      repositories = repositories.sublist(0, Constants.maxHistoryRepository);
      for (RepositoryItem repository in repos){
        remove(repository.id??0);
      }
    }
    return repositories;
  }
}
