import 'package:bontempo/components/cards/common_card.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:bontempo/screens/news_details/news_details_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd/MM/yyyy hh:mm');
    return CommonCard(
      buttonTitle: 'VER NOTÍCIA',
      image: news.thumbnail,
      title: news.title,
      afterTitle:
          f.format(new DateFormat("yyyy-MM-dd hh:mm:ss").parse(news.date)),
      onTap: () {
        Navigator.pushNamed(
          context,
          NewsDetailsViewRoute,
          arguments: NewsDetailsArguments(news: news),
        );
      },
    );
  }
}
