

import '../../di/service_locator.dart';
import '../storage/storage.dart';
import 'local_data_source.dart';

class AppLocalDataSource implements LocalDataSource {
  static final storage = serviceLocator<Storage>();


}
