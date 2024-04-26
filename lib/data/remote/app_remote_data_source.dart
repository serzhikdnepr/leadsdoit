import 'package:leadsdoit_project/core/app_result.dart';
import 'package:leadsdoit_project/data/mapper/remote_mappers.dart';
import 'package:leadsdoit_project/data/remote/remote_data_source.dart';
import 'package:leadsdoit_project/data/service/remote_service.dart';
import 'package:leadsdoit_project/di/service_locator.dart';
import 'package:leadsdoit_project/domain/exceptions/app_exceptions.dart';

import '../response/search_repository_response.dart';

class AppRemoteDataSource implements RemoteDataSource {
  static final service = serviceLocator<RemoteService>();

  @override
  Future<AppResult> searchRepositories(
      String text, int page, int perPage) async {
    try {
      final response = SearchRepositoryResponse.fromJson(
          await service.searchRepositories(text, page, perPage));
      return AppResult.success(mapToRepositoryList(response));
    } on AppException catch (error) {
      return AppResult.failure(error.message, error.codeError);
    } catch (e) {
      return AppResult.failure();
    }
  }
}
