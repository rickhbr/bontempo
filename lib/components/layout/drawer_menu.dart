import 'package:bontempo/blocs/authentication/index.dart';
import 'package:bontempo/components/images/avatar.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerMenu extends StatelessWidget {
  Widget renderButton({
    BuildContext? context,
    Widget? child,
    String? route,
    EdgeInsets? padding,
  }) {
    return Material(
      color: Colors.transparent,
      child: ButtonTheme(
        padding: EdgeInsets.zero,
        minWidth: double.infinity,
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(50),
                vertical: ScreenUtil().setHeight(20),
              ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context!).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                route!,
                route != HomeViewRoute
                    ? ModalRoute.withName(HomeViewRoute)
                    : (Route<dynamic> route) => route.isFirst,
                arguments: route == HomeViewRoute
                    ? HomeArguments(registerNotifications: false)
                    : null,
              );
            },
            child: Container(
              width: double.infinity,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List menuList = [
      {'title': 'HOME', 'route': HomeViewRoute},
      {'title': 'LOOKBOOK', 'route': LookBookViewRoute},
      {'title': 'RECEITAS', 'route': RecipesViewRoute},
      // {'title': 'KITCHEN CONTROL', 'route': KitchenControlViewRoute},
      // {'title': 'CONTROL KEY', 'route': ControlKeyViewRoute},
      {'title': 'MEU CLOSET', 'route': ClosetViewRoute},
      {'title': 'LISTA DE COMPRAS', 'route': ShoppingCartViewRoute},
      {'title': 'MEU ESTOQUE', 'route': StockViewRoute},
      {'title': 'DICAS DE FILMES', 'route': MoviesViewRoute},
      {'title': 'MOODBOARD', 'route': StoresViewRoute},
      {'title': 'NOTÍCIAS', 'route': NewsViewRoute},
    ];

    Map<String, dynamic> avatarData =
        RepositoryProvider.of<UserRepository>(context)
            .getUserFastParam("avatar");
    String avatarUrl = avatarData.isNotEmpty ? avatarData['url'] : null;
    print(avatarUrl);

    return Container(
      width: ScreenUtil().setWidth(328),
      child: Drawer(
        child: Container(
          width: ScreenUtil().setWidth(328),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: black[50]!.withOpacity(.3),
                          ),
                        ),
                      ),
                      child: this.renderButton(
                        context: context,
                        route: MyProfileViewRoute,
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(40),
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(26),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Avatar(
                              avatarUrl: null,
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Olá ${RepositoryProvider.of<UserRepository>(context).getUserFastParam("computed_firstname").toString()}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    'Editar Dados',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...menuList
                        .map(
                          (menuItem) => (this.renderButton(
                            context: context,
                            route: menuItem['route'],
                            child: Text(
                              menuItem['title'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                        )
                        .toList(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: black[50]!.withOpacity(.3),
                          ),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ButtonTheme(
                          padding: EdgeInsets.zero,
                          minWidth: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(50),
                              vertical: ScreenUtil().setHeight(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoggedOut());
                              },
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/logout.svg',
                                      color: black[50]!,
                                      width: ScreenUtil().setWidth(22),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Text(
                                      'Sair do App',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: black[50],
                                        fontSize: ScreenUtil().setSp(15),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
