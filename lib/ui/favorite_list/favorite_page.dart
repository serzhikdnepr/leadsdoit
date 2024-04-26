import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:leadsdoit_project/ui/favorite_list/favorite_bloc.dart';
import 'package:leadsdoit_project/ui/home/widgets/view_list_repositories.dart';
import 'package:leadsdoit_project/utils/app_utils.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/app_state.dart';
import '../../core/widget_state.dart';
import '../../domain/model/repository_item.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../utils/styles.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends WidgetSate<FavoritePage, FavoriteBloc> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<RepositoryItem>? _repositories;

  List<num> _ids = [];

  @override
  void initState() {
    bloc.streamController.stream.listen((data) {
      if (data is Failure) {
        showToast(data.message);
      } else if (data is ListRepositories) {
        _repositories = data.repositories;
      } else if (data is IdsFavorite) {
        _ids = data.list ?? [];
        bloc.getFavoriteRepos();
      }
    });
    bloc.getFavoriteIds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgPage,
      appBar: AppBar(
        title: Text(
          S.of(context).listOfFavoriteRepositories,
          style: titleStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(3)),
          child: Container(
            height: ScreenUtil().setHeight(3),
            width: double.infinity,
            color: colorDivider,
          ),
        ),
        leading: GFIconButton(
          color: GFColors.TRANSPARENT,
          iconSize: ScreenUtil().setWidth(44),
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
          icon: SvgPicture.asset(Assets.assetsBackBtn),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        backgroundColor: bgAppBar,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: bloc.streamController.stream,
          builder: (context, AsyncSnapshot<AppState> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (snapshot.hasData && snapshot.data is Loading) &&
                        _repositories == null
                    ? Center(
                        child: SizedBox(
                          width: ScreenUtil().setWidth(50),
                          child: const LoadingIndicator(
                            indicatorType: Indicator.lineSpinFadeLoader,
                            colors: [Colors.black12],
                          ),
                        ),
                      )
                    : _repositories != null && _repositories!.isNotEmpty
                        ? Expanded(
                            child: RepositoriesList(
                                repositories: _repositories!,
                                clickFavoriteBtn: (isFavorite, item) {
                                  isFavorite
                                      ? bloc.addFavorite(item)
                                      : bloc.deleteFavorite(item.id ?? 0);
                                },
                                favoriteIds: _ids))
                        : Expanded(
                            child: Center(
                            child: Text(
                              S.of(context).emptyFavoriteList,
                              style: emptyText,
                              textAlign: TextAlign.center,
                            ),
                          ))
              ],
            );
          }),
    );
  }
}
