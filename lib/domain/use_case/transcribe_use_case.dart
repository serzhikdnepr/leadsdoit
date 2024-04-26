import '../../core/app_result.dart';
import '../../data/dao/interface/common_dao.dart';
import '../model/repository_item.dart';
import '../repository/repository.dart';

abstract class SearchRepositoriesUseCase {
  Future<AppResult> execute(String text, int page, int perPage);
}

class SearchRepositoriesRequest implements SearchRepositoriesUseCase {
  final Repository repository;
  final HistoryCommonDao<RepositoryItem> _historyCommonDao;

  SearchRepositoriesRequest(
    this.repository, this._historyCommonDao,
  );

  @override
  Future<AppResult> execute(String text, int page, int perPage) async {
    final response = await repository.searchRepositories(text, page, perPage);
    switch (response.status) {
      case Status.SUCCESS:
        _historyCommonDao.addAll(response.data);
        return AppResult.success(response.data);
      default:
        return AppResult.failure(response.message);
    }
  }
}
