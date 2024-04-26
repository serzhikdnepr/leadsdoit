import 'dart:async';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:leadsdoit_project/di/service_locator.dart';
import 'package:leadsdoit_project/generated/l10n.dart';
import 'package:leadsdoit_project/provider/locale_model.dart';
import 'package:leadsdoit_project/router/router.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  }, (Object error, StackTrace stack) async {
    debugPrint("$error");
  });
}

class MyApp extends StatelessWidget {
  final _rootRouter = RootRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (_, child) => MultiProvider(
              providers: <SingleChildWidget>[
                ChangeNotifierProvider.value(value: LocaleModel()),
              ],
              child: Consumer<LocaleModel>(
                builder: (context, localeModel, child) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      FormBuilderLocalizations.delegate,
                    ],
                    locale: localeModel.locale,
                    supportedLocales: S.delegate.supportedLocales,
                    builder: (context, widget) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: widget!,
                      );
                    },
                    routerDelegate: _rootRouter.delegate(
                      navigatorObservers: () => [AutoRouteObserver()],
                    ),
                    routeInformationProvider: _rootRouter.routeInfoProvider(),
                    routeInformationParser: _rootRouter.defaultRouteParser(
                        includePrefixMatches: true),
                  );
                },
              ),
            ));
  }
}
