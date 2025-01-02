import 'package:bontempo/components/cards/news_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNewsCard extends StatelessWidget {
  final HomeModel home;

  const HomeNewsCard({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ColumnTitle(
          theme:
              home.mode == HomeMode.day ? CustomTheme.black : CustomTheme.white,
          lightTitle: 'Acompanhe as notícias',
          boldTitle: 'que mais lhe interessam.',
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(
                  context,
                  NewsViewRoute,
                ),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'VER TODAS',
                style: TextStyle(
                  color:
                      home.mode == HomeMode.day ? Colors.black : Colors.white,
                  fontSize: ScreenUtil().setSp(10),
                  fontWeight: FontWeight.w400,
                  letterSpacing: -.3,
                ),
              ),
            )),
        if (home.news != null && home.news.length > 0)
          ListView.builder(
            shrinkWrap: true,
            itemCount: home.news.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return NewsCard(
                news: home.news[index],
              );
            },
          ),
      ],
    );
  }
}
