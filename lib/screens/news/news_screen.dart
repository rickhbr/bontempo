import 'package:bontempo/blocs/news/index.dart';
import 'package:bontempo/components/cards/news_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/common_card_loader.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<NewsModel> _news = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<NewsBloc>(context).add(LoadNewsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
      BlocProvider.of<NewsBloc>(context).add(LoadNewsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<NewsBloc, NewsState>(
      listener: (BuildContext ctx, NewsState state) {
        if (state is ErrorNewsState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedNewsState) {
          setState(() {
            _news.addAll(state.items!);
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Notícias',
                description: 'Acompanhe as notícias que mais lhe interessam.',
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _news.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return NewsCard(news: _news[index]);
                        },
                      ),
                      BlocBuilder<NewsBloc, NewsState>(
                        builder: (BuildContext ctx, NewsState state) {
                          if (state is LoadingNewsState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _news.length > 0 ? 1 : 5,
                                CommonCardLoader(),
                              ).toList(),
                            );
                          }
                          if (state is LoadedNewsState && _news.length == 0) {
                            return NoResults(
                                text:
                                    "Nenhuma notícia encontrada com as categorias selecionadas.");
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
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
