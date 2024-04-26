import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';
import 'package:leadsdoit_project/generated/assets.dart';
import 'package:leadsdoit_project/utils/app_utils.dart';

import '../../../utils/styles.dart';

class RepositoryItemView extends StatelessWidget {
  final RepositoryItem repositoryItem;
  final bool isFavorite;
  final Function(bool isFavorite) clickFavoriteBtn;

  const RepositoryItemView(
      {super.key,
      required this.repositoryItem,
      this.isFavorite = false,
      required this.clickFavoriteBtn});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      if(!AppUtils.isFastDoubleClick()){
        launchURL(repositoryItem.htmlUrl);
      }
    },
      child: Container(
        padding: EdgeInsets.only(
            right: ScreenUtil().setWidth(16),
            left: ScreenUtil().setWidth(16),
            top: ScreenUtil().setWidth(18),
            bottom: ScreenUtil().setWidth(18)),
        decoration: BoxDecoration(
            color: bgField,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(10)))),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "${repositoryItem.description}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: descriptionStyle,
            )),
            GFIconButton(
                iconSize: ScreenUtil().setWidth(24),
                alignment: Alignment.center,
                size: ScreenUtil().setWidth(44),
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                color: Colors.transparent,
                icon: SvgPicture.asset(
                  Assets.assetsIconFavoriteActive,
                  colorFilter: ColorFilter.mode(
                      isFavorite
                          ? const Color(0xff1463F5)
                          : const Color(0xffBFBFBF),
                      BlendMode.srcIn),
                ),
                onPressed: () {
                  clickFavoriteBtn(!isFavorite);
                })
          ],
        ),
      ),
    );
  }
}
