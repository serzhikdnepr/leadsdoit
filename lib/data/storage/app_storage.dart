import 'package:leadsdoit_project/core/constants.dart';
import 'package:leadsdoit_project/data/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class AppStorage implements Storage {
  static final SharedPreferences _preferences =
      serviceLocator<SharedPreferences>();

  final String _prefSelectedLanguage = "pref_selected_language";

  @override
  String getLanguage() {
    final String? lang = _preferences.getString(_prefSelectedLanguage);

    return lang ?? Constants.appLang;
  }

  @override
  void saveLanguage(String lang) {
    _preferences.setString(_prefSelectedLanguage, lang);
  }
}
