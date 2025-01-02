import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/screens/clothes_config/clothes_config_arguments.dart';
import 'package:bontempo/screens/clothes_edit/clothes_edit_arguments.dart';
import 'package:bontempo/screens/home/home_arguments.dart';
import 'package:bontempo/screens/index.dart';
import 'package:bontempo/screens/library/library_page.dart';
import 'package:bontempo/screens/lookbook_manage/lookbook_manage_arguments.dart';
import 'package:bontempo/screens/lookbook_schedule_details/lookbook_schedule_details_arguments.dart';
import 'package:bontempo/screens/looks_select/looks_select_arguments.dart';
import 'package:bontempo/screens/movie_details/movie_details_arguments.dart';
import 'package:bontempo/screens/news_details/news_details_arguments.dart';
import 'package:bontempo/screens/notifications/notifications_page.dart';
import 'package:bontempo/screens/project/project_page.dart';
import 'package:bontempo/screens/project_create/project_create_page.dart';
import 'package:bontempo/screens/recipes_details/recipes_details_arguments.dart';
import 'package:bontempo/screens/stores/stores_page.dart';
import 'package:bontempo/screens/stores_details/stores_details_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'models/project_model.dart';
import 'models/store_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final int fadeDuration = 300;
  final int slideDuration = 300;
  switch (settings.name) {
    case SplashViewRoute:
      return PageTransition(
        child: SplashPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case LoginViewRoute:
      return PageTransition(
        child: LoginPage(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case RegisterViewRoute:
      return PageTransition(
        child: RegisterPage(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case MovieGenresViewRoute:
      return PageTransition(
        child: MovieGenresPage(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case NewsCategoriesViewRoute:
      return PageTransition(
        child: NewsCategoriesPage(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case GastronomyTypesViewRoute:
      return PageTransition(
        child: GastronomyTypesPage(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case HomeViewRoute:
      final args = settings.arguments as HomeArguments;
      return PageTransition(
        child: HomePage(
          registerNotifications: args.registerNotifications!,
        ),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case MoviesViewRoute:
      return PageTransition(
        child: MoviesPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case MovieDetailsViewRoute:
      final args = settings.arguments as MovieDetailsArguments;
      return PageTransition(
        child: MovieDetailsPage(movie: args.movie),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case NewsViewRoute:
      return PageTransition(
        child: NewsPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case NewsDetailsViewRoute:
      final args = settings.arguments as NewsDetailsArguments;
      return PageTransition(
        child: NewsDetailsPage(news: args.news),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case NotificationsViewRoute:
      return PageTransition(
        child: NotificationsPage(),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case ProjectViewRoute:
      final args = settings.arguments as ProjectModel;
      return PageTransition(
        child: ProjectPage(args),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case ProjectCreateViewRoute:
      final args = settings.arguments as int;
      return PageTransition(
        child: ProjectCreatePage(args),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case RecipesViewRoute:
      return PageTransition(
        child: RecipesPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case StoresViewRoute:
      return PageTransition(
        child: StoresPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case RecipesDetailsViewRoute:
      final args = settings.arguments as RecipesDetailsArguments;
      return PageTransition(
        child: RecipesDetailsPage(recipe: args.recipe!),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
      );
    case StoresDetailsViewRoute:
      final args = settings.arguments as StoreModel;
      return PageTransition(
        child: StoresDetailsPage(args),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
      );
    case LibraryViewRoute:
      return PageTransition(
        child: LibraryPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
      );
    case StockViewRoute:
      return PageTransition(
        child: StocksPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case ShoppingCartViewRoute:
      return PageTransition(
        child: ShoppingCartPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case LookBookViewRoute:
      return PageTransition(
        child: LookBookPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case MyLooksViewRoute:
      return PageTransition(
        child: MyLooksPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case LookBookInstructionsViewRoute:
      return PageTransition(
        child: LookBookInstructionsPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case LookBookAddViewRoute:
      return PageTransition(
        child: LookBookManagePage(),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case LookBookEditViewRoute:
      final args = settings.arguments as LookBookManageArguments;
      return PageTransition(
        child: LookBookManagePage(look: args.look),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case ClothesViewRoute:
      return PageTransition(
        child: ClothesPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case ClothesAddViewRoute:
      return PageTransition(
        child: ClothesAddPage(),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case ClothesEditViewRoute:
      final args = settings.arguments as ClothesEditArguments;
      return PageTransition(
        child: ClothesEditPage(
          clothing: args.clothing!,
          clothingBloc: args.clothingBloc!,
        ),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case ClothesConfigViewRoute:
      final args = settings.arguments as ClothesConfigArguments;
      return PageTransition(
        child: ClothesConfigPage(images: args.images!),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case LookBookScheduleViewRoute:
      return PageTransition(
        child: LookBookSchedulePage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case LookBookScheduleDetailsViewRoute:
      final args = settings.arguments as LookBookScheduleDetailsArguments;
      return PageTransition(
        child: LookBookScheduleDetailsPage(date: args.date),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case LooksSelectViewRoute:
      final args = settings.arguments as LooksSelectArguments;
      return PageTransition(
        child: LooksSelectPage(
          date: args.date,
          looksScheduleBloc: args.looksScheduleBloc,
        ),
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    case ClosetViewRoute:
      return PageTransition(
        child: ClosetPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case MyProfileViewRoute:
      return PageTransition(
        child: MyProfilePage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case UpdateGastronomyViewRoute:
      return PageTransition(
        child: UpdateGastronomyPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case UpdateMovieGenresViewRoute:
      return PageTransition(
        child: UpdateMovieGenresPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case UpdateNewsCategoriesViewRoute:
      return PageTransition(
        child: UpdateNewsCategoriesPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case UpdatePasswordViewRoute:
      return PageTransition(
        child: UpdatePasswordPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case UpdateProfileViewRoute:
      return PageTransition(
        child: UpdateProfilePage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    case NoConnectionViewRoute:
      return PageTransition(
        child: NoConnectionPage(),
        curve: Curves.decelerate,
        type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: slideDuration),
        settings: settings,
      );
    default:
      return PageTransition(
        child: StoresPage(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );
    /*HomeArguments args = settings.arguments;
      return PageTransition(
        child: HomePage(
          registerNotifications: args.registerNotifications,
        ),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: fadeDuration),
        settings: settings,
      );*/
  }
}
