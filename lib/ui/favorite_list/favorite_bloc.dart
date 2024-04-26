import 'package:dio/dio.dart';
import 'package:leadsdoit_project/data/dao/interface/common_dao.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';

import '../../core/app_result.dart';
import '../../core/app_state.dart';
import '../../core/bloc.dart';

import '../../domain/use_case/transcribe_use_case.dart';

abstract class FavoriteState extends AppState {}

class ListRepositories extends FavoriteState {
  List<RepositoryItem>? repositories;

  ListRepositories(this.repositories);
}

class IdsFavorite extends FavoriteState {
  List<num>? list;

  IdsFavorite(this.list);
}

class FavoriteBloc extends Bloc {
  final FavoriteCommonDao<RepositoryItem> _favoriteCommonDao;

  FavoriteBloc(this._favoriteCommonDao);

  void getFavoriteRepos() async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }
    List<RepositoryItem> repos = await _favoriteCommonDao.getAll();
    if (!streamController.isClosed) {
      streamController.sink.add(ListRepositories(repos));
    }
  }

  void getFavoriteIds() async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }
    List<num> ids = await _favoriteCommonDao.getIds();
    if (!streamController.isClosed) {
      streamController.sink.add(IdsFavorite(ids));
    }
  }

  void addFavorite(RepositoryItem repositoryItem) async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }
    await _favoriteCommonDao.add(repositoryItem);
    getFavoriteIds();
  }

  void deleteFavorite(num id) async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }
    await _favoriteCommonDao.remove(id);
    getFavoriteIds();
  }
}
