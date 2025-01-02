import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const Footer({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: black[400],
        height: ScreenUtil().setHeight(84),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(84),
                  child: TextButton(
                    child: Opacity(
                      opacity: 0.3,
                      child: SvgPicture.asset(
                        'assets/svg/lookbook.svg',
                        color: Colors.white,
                        width: ScreenUtil().setWidth(28),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LookBookViewRoute,
                        ModalRoute.withName(HomeViewRoute),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(84),
                  child: TextButton(
                    child: Opacity(
                      opacity: 0.3,
                      child: SvgPicture.asset(
                        'assets/svg/gastronomy.svg',
                        color: Colors.white,
                        width: ScreenUtil().setWidth(28),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RecipesViewRoute,
                        ModalRoute.withName(HomeViewRoute),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(84),
                  child: TextButton(
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: ScreenUtil().setWidth(22),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeViewRoute,
                        (Route<dynamic> route) => false,
                        arguments: HomeArguments(registerNotifications: false),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(84),
                  child: TextButton(
                    child: Opacity(
                      opacity: 0.3,
                      child: SvgPicture.asset(
                        'assets/svg/box.svg',
                        color: Colors.white,
                        width: ScreenUtil().setWidth(28),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        StockViewRoute,
                        ModalRoute.withName(HomeViewRoute),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: ScreenUtil().setHeight(84),
                  child: TextButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.white.withOpacity(.3),
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(4),
                          ),
                          height: ScreenUtil().setHeight(3),
                          width: ScreenUtil().setWidth(25),
                        ),
                        Container(
                          color: Colors.white.withOpacity(.3),
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(4),
                          ),
                          height: ScreenUtil().setHeight(3),
                          width: ScreenUtil().setWidth(20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      this.scaffoldKey!.currentState!.openEndDrawer();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
