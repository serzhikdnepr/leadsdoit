import 'package:flutter/material.dart';
import 'package:leadsdoit_project/core/bloc.dart';

import '../di/service_locator.dart';

abstract class WidgetSate<T extends StatefulWidget, B extends Bloc>
    extends State<T> {
  late B bloc;

  WidgetSate() {
    bloc = serviceLocator<B>();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }
}
