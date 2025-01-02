import 'package:bontempo/components/account/account_avatar.dart';
import 'package:bontempo/components/buttons/button_group.dart';
import 'package:bontempo/components/buttons/lookbook_button.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return SafeArea(
      child: CustomScrollView(
        physics: new ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: CommonHeader(
              kToolbarHeight: ScreenUtil().setWidth(72),
              expandedHeight: ScreenUtil().setWidth(120),
              title: 'Meu Perfil',
              description:
                  'Aqui você pode atualizar as informações que achar necessário.',
              descriptionPadding: 78.0,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    ScreenUtil().setWidth(150) -
                    ScreenUtil().setHeight(84),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setHeight(36),
                  top: ScreenUtil().setWidth(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AccountAvatar(),
                    ButtonGroup(
                      buttons: <Widget>[
                        LookBookButton(
                          title: 'MEUS DADOS',
                          icon: 'assets/svg/user.svg',
                          route: UpdateProfileViewRoute,
                        ),
                        LookBookButton(
                          title: 'ALTERAR SENHA',
                          icon: 'assets/svg/lock.svg',
                          route: UpdatePasswordViewRoute,
                        ),
                      ],
                    ),
                    ButtonGroup(
                      buttons: <Widget>[
                        LookBookButton(
                          title: 'CULINÁRIA',
                          icon: 'assets/svg/cutlery.svg',
                          route: UpdateGastronomyViewRoute,
                        ),
                        LookBookButton(
                          title: 'FILMES',
                          icon: 'assets/svg/movies.svg',
                          route: UpdateMovieGenresViewRoute,
                        ),
                        LookBookButton(
                          title: 'NOTÍCIAS',
                          icon: 'assets/svg/news.svg',
                          route: UpdateNewsCategoriesViewRoute,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
