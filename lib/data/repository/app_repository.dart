import '../../core/app_result.dart';
import '../../di/service_locator.dart';
import '../../domain/repository/repository.dart';
import '../local/local_data_source.dart';
import '../remote/remote_data_source.dart';

class AppRepository implements Repository {
  static final remoteDataSource = serviceLocator<RemoteDataSource>();
  static final localDataSource = serviceLocator<LocalDataSource>();

  @override
  Future<AppResult> searchRepositories(String text, int page, int perPage) =>
      remoteDataSource.searchRepositories(text, page, perPage);
}
