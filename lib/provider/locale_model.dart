import 'dart:io';

import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../data/storage/storage.dart';
import '../di/service_locator.dart';

class LocaleModel extends ChangeNotifier {
  static const localeValueList = ['en'];

  static final storage = serviceLocator<Storage>();
  String? _localeIndex;
  int? _localeIndexList;

  String? get localeIndex => _localeIndex;

  int? get localeIndexList => _localeIndexList;

  Locale? get locale {
    if (_localeIndex != null && _localeIndex!.isNotEmpty) {
      var value = storage.getLanguage();
      return Locale(value);
    }

    return null;
  }

  LocaleModel() {
    String language = storage.getLanguage();

    if (language == '') {
      String currentLocale = Constants.appLang;
      try {
        currentLocale = Platform.localeName.toLowerCase();
      } catch (e) {
        currentLocale = Constants.appLang;
      }
      if (currentLocale.isNotEmpty) {
        currentLocale = currentLocale.toLowerCase();
      }
      if (currentLocale.isNotEmpty && currentLocale.length > 2) {
        if (currentLocale[2] == "-" || currentLocale[2] == "_") {
          language = currentLocale.substring(0, 2);
        }
      } else {
        language = currentLocale.isNotEmpty ? currentLocale : Constants.appLang;
      }
      storage.saveLanguage(language);
    }
    if (!localeValueList.contains(language)) {
      language = "en";
      storage.saveLanguage(language);
    }
    _localeIndex = language;
  }

  switchLocale(int index) {
    _localeIndex = localeValueList[index];
    notifyListeners();
    storage.saveLanguage(_localeIndex!);
  }

  static String localeName(index) {
    switch (index) {
      case 0:
        return 'English';
      case 1:
        return 'Українська';
      default:
        return '';
    }
  }
}
