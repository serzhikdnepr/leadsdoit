class Constants {
  Constants._();

  static const String url = "https://api.github.com";

  /* without detailed technical specifications,
  I made a restriction for the favorites */
  static const int countFavorites = 50;

  /*  Also at the moment I have limited the
  number of entries in the browsing history.*/
  static const int maxHistoryRepository = 100;

  /*Set the default language, in this example there is only one*/
  static const String appLang = "en";
}
