import '../../core/app_result.dart';

abstract class Repository {
  Future<AppResult> searchRepositories(String text, int page, int perPage);
}
