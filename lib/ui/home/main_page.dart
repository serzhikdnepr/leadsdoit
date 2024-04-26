import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:leadsdoit_project/core/constants.dart';
import 'package:leadsdoit_project/router/router.gr.dart';
import 'package:leadsdoit_project/ui/home/widgets/search_widget.dart';
import 'package:leadsdoit_project/ui/home/widgets/view_list_repositories.dart';
import 'package:leadsdoit_project/ui/home/widgets/view_repository.dart';
import 'package:leadsdoit_project/utils/app_utils.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/app_state.dart';
import '../../core/widget_state.dart';
import '../../domain/model/repository_item.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../utils/styles.dart';
import 'home_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends WidgetSate<HomePage, HomeBloc> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<RepositoryItem>? _repositories;

  List<RepositoryItem>? _repositoriesHistory;

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
      } else if (data is ListHistoryRepositories) {
        _repositoriesHistory = data.repositories;
      }
    });
    bloc.getHistoryRepositories();
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (query.length >= 4) {
      _repositories = null;
      bloc.searchRepositories(query);
    } else {
      if (query.isEmpty) {
        _repositories = null;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgPage,
      appBar: AppBar(
        title: Text(
          S.of(context).titleApp,
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
        backgroundColor: bgAppBar,
        centerTitle: true,
        actions: [
          GFIconButton(
            color: GFColors.TRANSPARENT,
            iconSize: ScreenUtil().setWidth(44),
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(16)),
            icon: SvgPicture.asset(Assets.assetsStarButton),
            onPressed: () async {
              await context.router.push(const FavoritePage());
              bloc.getFavoriteIds();
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: bloc.streamController.stream,
          builder: (context, AsyncSnapshot<AppState> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(16),
                      left: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setWidth(24)),
                  child: SearchWidget(onSearchChanged: _onSearchChanged),
                ),
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
                    : _repositories != null
                        ? Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(16),
                                    left: ScreenUtil().setWidth(16),
                                    right: ScreenUtil().setWidth(16),
                                    bottom: ScreenUtil().setWidth(4)),
                                child: Text(
                                  _repositories!.isNotEmpty
                                      ? S.of(context).whatWeHaveFound
                                      : S.of(context).whatWeFound,
                                  style: descriptionRepository,
                                ),
                              ),
                              Expanded(
                                  child: _repositories!.isNotEmpty
                                      ? RepositoriesList(
                                          repositories: _repositories!,
                                          clickFavoriteBtn: (isFavorite, item) {
                                            addOrDeleteFavorite(
                                                isFavorite, item);
                                          },
                                          favoriteIds: _ids)
                                      : Center(
                                          child: Text(
                                            S.of(context).emptyFound,
                                            style: emptyText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                            ],
                          ))
                        : Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(16),
                                    left: ScreenUtil().setWidth(16),
                                    right: ScreenUtil().setWidth(16),
                                    bottom: ScreenUtil().setWidth(4)),
                                child: Text(
                                  S.of(context).searchHistory,
                                  style: descriptionRepository,
                                ),
                              ),
                              Expanded(
                                  child: _repositoriesHistory != null &&
                                          _repositoriesHistory!.isNotEmpty
                                      ? RepositoriesList(
                                          repositories: _repositoriesHistory!,
                                          clickFavoriteBtn: (isFavorite, item) {
                                            addOrDeleteFavorite(
                                                isFavorite, item);
                                          },
                                          favoriteIds: _ids)
                                      : Center(
                                          child: Text(
                                            S.of(context).emptyHistory,
                                            style: emptyText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                            ],
                          ))
              ],
            );
          }),
    );
  }

  void addOrDeleteFavorite(bool isFavorite, RepositoryItem item) {
    isFavorite
        ? (Constants.countFavorites >
        _ids.length)
        ? bloc.addFavorite(item)
        : showToast(S
        .of(context)
        .exceededFavorite)
        : bloc.deleteFavorite(
        item.id ?? 0);
  }
}
