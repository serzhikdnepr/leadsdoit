// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:leadsdoit_project/ui/favorite_list/favorite_page.dart' as _i1;
import 'package:leadsdoit_project/ui/home/main_page.dart' as _i2;

abstract class $RootRouter extends _i3.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    FavoritePage.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FavoritePage(),
      );
    },
    HomePage.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.FavoritePage]
class FavoritePage extends _i3.PageRouteInfo<void> {
  const FavoritePage({List<_i3.PageRouteInfo>? children})
      : super(
          FavoritePage.name,
          initialChildren: children,
        );

  static const String name = 'FavoritePage';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomePage extends _i3.PageRouteInfo<void> {
  const HomePage({List<_i3.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
