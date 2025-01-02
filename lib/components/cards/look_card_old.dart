import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LookCardOld extends StatelessWidget {
  final LookModel look;
  final double paddingBottom;
  final Widget? buttons;

  const LookCardOld({
    Key? key,
    required this.look,
    this.paddingBottom = 25,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(bottom: ScreenUtil().setWidth(this.paddingBottom)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            blurRadius: 24.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: ScreenUtil().setHeight(230),
                  minWidth: ScreenUtil().setWidth(214),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(15),
                  ),
                  child: Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(70),
                        ),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: look.clothing!
                            .where((ClothingModel item) => item.isMain)
                            .map(
                              (ClothingModel item) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(10),
                                ),
                                width: ScreenUtil().setWidth(214),
                                child: Center(
                                  child: Image.network(
                                    item.picture,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(194),
                                    loadingBuilder: (BuildContext ctx,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: SizedBox(
                                          height: ScreenUtil().setWidth(28),
                                          width: ScreenUtil().setWidth(28),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              black,
                                            ),
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        width: ScreenUtil().setWidth(60),
                        child: Container(
                          width: ScreenUtil().setWidth(60),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0, 1],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        width: ScreenUtil().setWidth(60),
                        child: Container(
                          width: ScreenUtil().setWidth(60),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0, 1],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (look.clothing!
                  .where((ClothingModel item) => !item.isMain)
                  .isNotEmpty)
                Container(
                  height: ScreenUtil().setWidth(130),
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                        ),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: look.clothing!
                            .where((ClothingModel item) => !item.isMain)
                            .map(
                              (ClothingModel item) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(5),
                                  ),
                                  width: ScreenUtil().setWidth(102),
                                  height: ScreenUtil().setWidth(125),
                                  child: Image.network(
                                    item.picture,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(102),
                                    height: ScreenUtil().setWidth(125),
                                    loadingBuilder: (BuildContext ctx,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: SizedBox(
                                          height: ScreenUtil().setWidth(14),
                                          width: ScreenUtil().setWidth(14),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              black,
                                            ),
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            )
                            .toList(),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        width: ScreenUtil().setWidth(60),
                        child: Container(
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setWidth(110),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0, 1],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        width: ScreenUtil().setWidth(60),
                        child: Container(
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setWidth(110),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0, 1],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (buttons != null)
            Positioned(
              right: ScreenUtil().setWidth(12),
              top: ScreenUtil().setWidth(12),
              child: buttons!,
            ),
        ],
      ),
    );
  }
}
