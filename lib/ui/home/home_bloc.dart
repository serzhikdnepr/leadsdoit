import 'package:dio/dio.dart';
import 'package:leadsdoit_project/data/dao/interface/common_dao.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';

import '../../core/app_result.dart';
import '../../core/app_state.dart';
import '../../core/bloc.dart';

import '../../domain/use_case/transcribe_use_case.dart';

abstract class HomeState extends AppState {}

class ListRepositories extends HomeState {
  List<RepositoryItem>? repositories;

  ListRepositories(this.repositories);
}

class ListHistoryRepositories extends HomeState {
  List<RepositoryItem>? repositories;

  ListHistoryRepositories(this.repositories);
}

class IdsFavorite extends HomeState {
  List<num>? list;

  IdsFavorite(this.list);
}

class HomeBloc extends Bloc {
  final SearchRepositoriesUseCase _searchRepositoriesUseCase;
  final FavoriteCommonDao<RepositoryItem> _favoriteCommonDao;
  final HistoryCommonDao<RepositoryItem> _historyCommonDao;

  HomeBloc(this._searchRepositoriesUseCase, this._favoriteCommonDao, this._historyCommonDao);

  void searchRepositories(String text, {int page = 0, int perPage = 15}) async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }

    final response =
        await _searchRepositoriesUseCase.execute(text, page, perPage);
    switch (response.status) {
      case Status.SUCCESS:
        if (!streamController.isClosed) {
          streamController.sink.add(ListRepositories(response.data));
        }
        getHistoryRepositories();
        break;
      case Status.FAILURE:
        if (!streamController.isClosed) {
          streamController.sink.add(Failure(response.message));
        }
        break;
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

  void getHistoryRepositories() async {
    if (!streamController.isClosed) {
      streamController.add(Loading());
    }
    List<RepositoryItem> repos = await _historyCommonDao.getAll();
    if (!streamController.isClosed) {
      streamController.sink.add(ListHistoryRepositories(repos));
    }
  }
}
