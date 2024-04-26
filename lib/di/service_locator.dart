import 'package:get_it/get_it.dart';
import 'package:leadsdoit_project/data/dao/favorite_dao.dart';
import 'package:leadsdoit_project/data/dao/history_dao.dart';
import 'package:leadsdoit_project/data/http_manager/app_http_manager.dart';
import 'package:leadsdoit_project/data/http_manager/http_manager.dart';
import 'package:leadsdoit_project/data/remote/app_remote_data_source.dart';
import 'package:leadsdoit_project/data/remote/remote_data_source.dart';
import 'package:leadsdoit_project/data/repository/app_repository.dart';
import 'package:leadsdoit_project/data/service/app_remote_service.dart';
import 'package:leadsdoit_project/data/service/remote_service.dart';
import 'package:leadsdoit_project/data/storage/app_storage.dart';
import 'package:leadsdoit_project/data/storage/storage.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';
import 'package:leadsdoit_project/domain/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/dao/interface/common_dao.dart';
import '../domain/use_case/transcribe_use_case.dart';
import '../ui/favorite_list/favorite_bloc.dart';
import '../ui/home/home_bloc.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(preferences);

  serviceLocator.registerSingleton<Repository>(AppRepository());

  serviceLocator.registerLazySingleton<HttpManager>(() => AppHttpManager());
  serviceLocator
      .registerLazySingleton<RemoteDataSource>(() => AppRemoteDataSource());

  serviceLocator.registerLazySingleton<RemoteService>(() => AppRemoteService());

  serviceLocator.registerLazySingleton<Storage>(() => AppStorage());
  serviceLocator.registerLazySingleton<FavoriteCommonDao<RepositoryItem>>(
      () => FavoriteDao());
  serviceLocator.registerLazySingleton<HistoryCommonDao<RepositoryItem>>(
      () => HistoryDao());

  serviceLocator.registerFactory(() => HomeBloc(
        serviceLocator.get(),
        serviceLocator.get(),
        serviceLocator.get(),
      ));

  serviceLocator.registerFactory(() => FavoriteBloc(serviceLocator.get()));

  serviceLocator.registerFactory<SearchRepositoriesUseCase>(
      () => SearchRepositoriesRequest(
            serviceLocator.get(),
            serviceLocator.get(),
          ));
}
