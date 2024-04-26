// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `network_exception`
  String get network_exception {
    return Intl.message(
      'network_exception',
      name: 'network_exception',
      desc: '',
      args: [],
    );
  }

  /// `Github repos list`
  String get titleApp {
    return Intl.message(
      'Github repos list',
      name: 'titleApp',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `What we have found`
  String get whatWeHaveFound {
    return Intl.message(
      'What we have found',
      name: 'whatWeHaveFound',
      desc: '',
      args: [],
    );
  }

  /// `What we found`
  String get whatWeFound {
    return Intl.message(
      'What we found',
      name: 'whatWeFound',
      desc: '',
      args: [],
    );
  }

  /// `Nothing was find for your search.\nPlease check the spelling`
  String get emptyFound {
    return Intl.message(
      'Nothing was find for your search.\nPlease check the spelling',
      name: 'emptyFound',
      desc: '',
      args: [],
    );
  }

  /// `Search History`
  String get searchHistory {
    return Intl.message(
      'Search History',
      name: 'searchHistory',
      desc: '',
      args: [],
    );
  }

  /// `You have empty history.\nClick on search to start journey!`
  String get emptyHistory {
    return Intl.message(
      'You have empty history.\nClick on search to start journey!',
      name: 'emptyHistory',
      desc: '',
      args: [],
    );
  }

  /// `Favorite repos list`
  String get listOfFavoriteRepositories {
    return Intl.message(
      'Favorite repos list',
      name: 'listOfFavoriteRepositories',
      desc: '',
      args: [],
    );
  }

  /// `You have no favorites.\nClick on star while searching to add first favorite`
  String get emptyFavoriteList {
    return Intl.message(
      'You have no favorites.\nClick on star while searching to add first favorite',
      name: 'emptyFavoriteList',
      desc: '',
      args: [],
    );
  }

  /// `The number of saved repositories has been exceeded`
  String get exceededFavorite {
    return Intl.message(
      'The number of saved repositories has been exceeded',
      name: 'exceededFavorite',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
