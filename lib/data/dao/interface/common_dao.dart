import 'dart:async';


abstract class FavoriteCommonDao<Entity> {
  Future<bool> add(Entity e);

  Future<void> addAll(List<Entity> e);

  Future<bool> remove(num id);

  Future<bool> update(Entity model);

  Future<Entity?> find(num id);

  Future<List<num>> getIds();

  Future<List<Entity>> getAll();
}
abstract class HistoryCommonDao<Entity> {
  Future<bool> add(Entity e);

  Future<void> addAll(List<Entity> e);

  Future<bool> remove(num id);

  Future<bool> update(Entity model);

  Future<Entity?> find(num id);

  Future<List<Entity>> getAll();
}


