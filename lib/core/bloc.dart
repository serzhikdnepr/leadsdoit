import 'dart:async';

import 'package:leadsdoit_project/core/app_state.dart';

abstract class Bloc {
  final StreamController<AppState> streamController =
      StreamController<AppState>.broadcast();

  void onDispose() {
    streamController.close();
  }
}
