import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../generated/assets.dart';

Color colorTitleText = const Color(0xff211814);
Color bgAppBar = const Color(0xffF9F9F9);
Color bgPage = const Color(0xffF9F9F9);
Color colorDivider = const Color(0xffF2F2F2);
Color bgField = const Color(0xffF2F2F2);
Color mainColor = const Color(0xff1463F5);
Color hintColor = const Color(0xffBFBFBF);

final TextStyle ralewayStyle = TextStyle(
    fontFamily: "Raleway",
    height: 1.1875,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400);

final TextStyle titleStyle = ralewayStyle.copyWith(
    color: colorTitleText,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w600);

final TextStyle searchStyle = ralewayStyle.copyWith(
    color: colorTitleText,
    fontSize: ScreenUtil().setSp(14),
    height: 1.41,
    fontWeight: FontWeight.w400);

final TextStyle searchHintStyle = ralewayStyle.copyWith(
    color: hintColor,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w400);

final TextStyle descriptionStyle = ralewayStyle.copyWith(
    color: colorTitleText,
    fontSize: ScreenUtil().setSp(14),
    height: 1.41,
    fontWeight: FontWeight.w400);

final TextStyle descriptionRepository = ralewayStyle.copyWith(
    color: mainColor,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w600);

final TextStyle emptyText = ralewayStyle.copyWith(
    color: hintColor,
    height: 1.41,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400);

InputDecoration inputDecoration(String searchHint,bool hasFocus, Function()? btnClear) =>
    InputDecoration(
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28))),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: mainColor,
                width: ScreenUtil().setWidth(2)),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28)))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent, width: ScreenUtil().setWidth(2)),
          borderRadius: BorderRadius.all(
            Radius.circular(ScreenUtil().setWidth(28)),
          ),
        ),
        filled: true,
        fillColor: hasFocus ? const Color(0xffE5EDFF) : const Color(0xffF2F2F2),
        hintStyle: searchHintStyle,
        prefixIcon: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
            child: SizedBox(
              width: ScreenUtil().setWidth(24),
              height: ScreenUtil().setWidth(24),
              child: SvgPicture.asset(Assets.assetsIconSearch),
            )),
        suffixIcon: btnClear != null
            ? Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                child: GFIconButton(padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(Assets.assetsIconClear),
                  onPressed: btnClear,
                  iconSize: ScreenUtil().setWidth(24),
                  color: Colors.transparent,
                ))
            : null,
        hintText: searchHint);
