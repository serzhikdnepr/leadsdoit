// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "emptyFavoriteList": MessageLookupByLibrary.simpleMessage(
            "You have no favorites.\nClick on star while searching to add first favorite"),
        "emptyFound": MessageLookupByLibrary.simpleMessage(
            "Nothing was find for your search.\nPlease check the spelling"),
        "emptyHistory": MessageLookupByLibrary.simpleMessage(
            "You have empty history.\nClick on search to start journey!"),
        "exceededFavorite": MessageLookupByLibrary.simpleMessage(
            "The number of saved repositories has been exceeded"),
        "listOfFavoriteRepositories":
            MessageLookupByLibrary.simpleMessage("Favorite repos list"),
        "network_exception":
            MessageLookupByLibrary.simpleMessage("network_exception"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchHistory": MessageLookupByLibrary.simpleMessage("Search History"),
        "titleApp": MessageLookupByLibrary.simpleMessage("Github repos list"),
        "whatWeFound": MessageLookupByLibrary.simpleMessage("What we found"),
        "whatWeHaveFound":
            MessageLookupByLibrary.simpleMessage("What we have found")
      };
}
