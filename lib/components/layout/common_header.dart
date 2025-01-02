import 'dart:math';

import 'package:bontempo/components/buttons/circle_back_button.dart';
import 'package:bontempo/components/buttons/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double kToolbarHeight;
  final double descriptionPadding;
  final double titlePadding;
  final double descriptionSpace;
  final bool backButton;
  final String backRoute;
  final bool multiLineTitle;
  String? title = '';
  String? description = '';

  CommonHeader({
    required this.expandedHeight,
    required this.kToolbarHeight,
    this.title,
    this.description,
    this.backRoute = '',
    descriptionPadding,
    descriptionSpace,
    titlePadding,
    backButton,
    multiLineTitle,
  })  : this.descriptionPadding = descriptionPadding ?? 100.0,
        this.titlePadding = titlePadding ?? 50,
        this.descriptionSpace = descriptionSpace ?? 0,
        this.backButton = backButton ?? false,
        this.multiLineTitle = multiLineTitle ?? false,
        super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double diff = expandedHeight - kToolbarHeight;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: expandedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(
                    0, 0, 0, min(0.1, (shrinkOffset / diff / 10))),
                blurRadius: ScreenUtil().setWidth(3.0),
                spreadRadius: 0.0,
                offset: Offset(0.0, ScreenUtil().setWidth(3.0)),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(this.titlePadding),
              right: ScreenUtil().setWidth(this.titlePadding),
              top: ScreenUtil().setWidth(this.multiLineTitle
                  ? max(
                      12,
                      20 - (shrinkOffset / 2),
                    )
                  : 20),
            ),
            width: double.infinity,
            child: Center(
              child: Text(
                this.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  height: this.multiLineTitle ? .92 : 1,
                  letterSpacing: -.5,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(27),
                ),
              ),
            ),
          ),
        ),
        if (this.backButton)
          Positioned(
            top: ScreenUtil().setWidth(12),
            left: ScreenUtil().setWidth(18),
            child: CircleBackButton(route: this.backRoute),
          ),
        Positioned(
          top: ScreenUtil().setWidth(12),
          right: ScreenUtil().setWidth(18),
          child: NotificationButton(),
        ),
        if (ScreenUtil().setWidth(67) - (shrinkOffset / 2) >=
            ScreenUtil().setWidth(40))
          Positioned(
            top: max(
              ScreenUtil().setWidth(40),
              ScreenUtil().setWidth(67) - (shrinkOffset / 2),
            ),
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(this.descriptionPadding),
                right: ScreenUtil().setWidth(this.descriptionPadding),
                top: ScreenUtil().setWidth(this.descriptionSpace),
              ),
              child: Opacity(
                opacity: min(
                  1,
                  max(
                    0,
                    (1 - (shrinkOffset * 3) / expandedHeight),
                  ),
                ),
                child: Text(
                  this.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
