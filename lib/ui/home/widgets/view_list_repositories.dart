import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';
import 'package:leadsdoit_project/ui/home/widgets/view_repository.dart';

import '../../../utils/app_utils.dart';

class RepositoriesList extends StatelessWidget {
  final List<RepositoryItem> repositories;
  final List<num> favoriteIds;
  final Function(bool isFavorite, RepositoryItem item) clickFavoriteBtn;

  const RepositoriesList(
      {super.key,
      required this.repositories,
      required this.clickFavoriteBtn,
      required this.favoriteIds});

  bool isFavorite(num? id) {
    return favoriteIds.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: repositories.length,
      padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var repository = repositories[index];
        return RepositoryItemView(
          repositoryItem: repository,
          isFavorite: isFavorite(repository.id),
          clickFavoriteBtn: (bool isFavorite) {
            if (!AppUtils.isFastDoubleClick()) {
              clickFavoriteBtn(isFavorite, repository);
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.transparent,
          height: ScreenUtil().setWidth(8),
          thickness: ScreenUtil().setWidth(8),
        );
      },
    );
  }
}
