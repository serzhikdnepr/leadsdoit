import 'package:dio/dio.dart';
import 'package:leadsdoit_project/data/service/remote_service.dart';

import '../../di/service_locator.dart';
import '../http_manager/http_manager.dart';

class AppRemoteService implements RemoteService {
  static final httpManager = serviceLocator<HttpManager>();

  @override
  Future searchRepositories(String text, int page, int perPage) async {
    return await httpManager.get(
        url: '/search/repositories',
        query: {"q": text, "page": page, "per_page": perPage});
  }
}
