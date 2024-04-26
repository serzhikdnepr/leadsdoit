import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leadsdoit_project/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class RootRouter extends $RootRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        reverseDurationInMilliseconds: 400,
        transitionsBuilder: (ctx, animation1, animation2, child) {
          debugPrint('Anim2 ${animation2.value}');
          return child;
        },
      );

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomePage.page, initial: true),
    AutoRoute(
      path: '/favoritePage',
      page: FavoritePage.page,
    ),

    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
