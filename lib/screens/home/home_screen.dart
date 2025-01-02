import 'dart:async';

import 'package:bontempo/blocs/home/index.dart';
import 'package:bontempo/blocs/home_look/home_look_bloc.dart';
import 'package:bontempo/components/home/home_food_app_card.dart';
import 'package:bontempo/components/home/home_look_card.dart';
import 'package:bontempo/components/home/home_movie_card.dart';
import 'package:bontempo/components/home/home_news_card.dart';
import 'package:bontempo/components/home/home_recipes_card.dart';
import 'package:bontempo/components/home/home_restaurants_card.dart';
import 'package:bontempo/components/loaders/common_card_loader.dart';
import 'package:bontempo/components/loaders/home_look_loader.dart';
import 'package:bontempo/components/loaders/row_title_loader.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/utils/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeMode _mode = TimeOfDay.now().hour >= 5 && TimeOfDay.now().hour < 19
      ? HomeMode.day
      : HomeMode.night;
  String _weatherClouds = "clear_skies";
  Completer? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadHomeEvent());
    _refreshCompleter = new Completer();
  }

  List<Widget> getCards(LoadedHomeState state) {
    List<Widget> cards = [];
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    if (state.home.weather != null) {
      cards.add(
        Text(
          'Hoje faz ${state.home.weather!.temperature}°C! ${parseClouds(state.home.mode, this._weatherClouds)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor(state.home.mode),
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w400,
            letterSpacing: -0.2,
          ),
        ),
      );
    }

    if (this._mode == HomeMode.day) {
      if (state.home.clothing.isNotEmpty) {
        cards.add(
          BlocProvider.value(
            value: BlocProvider.of<HomeLookBloc>(context),
            child: HomeLookCard(
              home: state.home,
              isSuggestion: true,
            ),
          ),
        );
      }
      if (state.home.scheduled.isNotEmpty) {
        cards.add(
          BlocProvider.value(
            value: BlocProvider.of<HomeLookBloc>(context),
            child: HomeLookCard(
              home: state.home,
              isSuggestion: false,
            ),
          ),
        );
      }
      cards.add(HomeRecipesCard(home: state.home));
      if (state.home.restaurantCard != null)
        cards.add(HomeRestaurantsCard(home: state.home));
      if (TimeOfDay.now().hour >= 11 && TimeOfDay.now().hour <= 12)
        cards.add(HomeFoodAppCard(home: state.home));
      cards.add(HomeMovieCard(home: state.home));
    } else {
      cards.add(HomeMovieCard(home: state.home));

      if (TimeOfDay.now().hour >= 18 && TimeOfDay.now().hour <= 22)
        cards.add(HomeFoodAppCard(home: state.home));
      if (state.home.clothing.isNotEmpty) {
        cards.add(
          BlocProvider.value(
            value: BlocProvider.of<HomeLookBloc>(context),
            child: HomeLookCard(
              home: state.home,
              isSuggestion: true,
            ),
          ),
        );
      }
      if (state.home.scheduled.isNotEmpty) {
        cards.add(
          BlocProvider.value(
            value: BlocProvider.of<HomeLookBloc>(context),
            child: HomeLookCard(
              home: state.home,
              isSuggestion: false,
            ),
          ),
        );
      }
      if (TimeOfDay.now().hour >= 18 && TimeOfDay.now().hour <= 22) {
        if (state.home.restaurantCard != null)
          cards.add(HomeRestaurantsCard(home: state.home));
        cards.add(HomeRecipesCard(home: state.home));
      }
    }
    if (state.home.news.isNotEmpty) cards.add(HomeNewsCard(home: state.home));
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LoadedHomeState) {
          setState(() {
            _mode = state.home.mode;
            _weatherClouds = state.home.weather?.clouds ?? "clear_skies";
          });
          _refreshCompleter?.complete();
          _refreshCompleter = new Completer();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: backgroundColor(this._mode),
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(LoadHomeEvent());
            return _refreshCompleter!.future;
          },
          child: SingleChildScrollView(
            physics: new AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    parseBackground(this._mode, this._weatherClouds),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30),
                        bottom: ScreenUtil().setHeight(15),
                        top: ScreenUtil().setWidth(54),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            parseIcon(this._mode, this._weatherClouds),
                            SizedBox(
                              height: ScreenUtil().setWidth(11),
                            ),
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  top: ScreenUtil().setWidth(-4),
                                  child: Text(
                                    'Olá ${RepositoryProvider.of<UserRepository>(context).getUserFastParam("computed_firstname").toString()},',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: textColor(this._mode),
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.1,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/svg/welcome.svg',
                                  color: textColor(
                                    this._mode,
                                    blueNight: true,
                                  ),
                                  width: ScreenUtil().setWidth(290),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(25),
                            ),
                          ]),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/banner.png',
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, StoresViewRoute),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30),
                        bottom: ScreenUtil().setHeight(36),
                        top: ScreenUtil().setWidth(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (BuildContext ctx, HomeState state) {
                              if (state is LoadedHomeState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: this.getCards(state),
                                );
                              }
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBoxLoader(
                                      width: ScreenUtil().setWidth(250),
                                      height: ScreenUtil().setWidth(20),
                                    ),
                                    if (this._mode == HomeMode.day)
                                      ...[
                                        HomeLookLoader(),
                                        RowTitleLoader(),
                                        CommonCardLoader(),
                                      ].toList(),
                                    if (this._mode == HomeMode.night)
                                      ...[
                                        RowTitleLoader(),
                                        CommonCardLoader(),
                                        RowTitleLoader(),
                                        CommonCardLoader(),
                                      ].toList(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color backgroundColor(HomeMode mode) {
    return mode == HomeMode.day ? Colors.transparent : Colors.black;
  }
}
