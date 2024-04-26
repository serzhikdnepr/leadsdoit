import '../../core/app_result.dart';

abstract class RemoteDataSource {
  Future<AppResult> searchRepositories(String text, int page, int perPage);
}
