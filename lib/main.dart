import 'package:bontempo/blocs/authentication/index.dart';
import 'package:bontempo/blocs/gastronomy_types/gastronomy_types_bloc.dart';
import 'package:bontempo/blocs/movie_genres/movie_genres_bloc.dart';
import 'package:bontempo/providers/api.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/router.dart' as router;
import 'package:bontempo/screens/index.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/news_categories/news_categories_bloc.dart';
import 'constants/routes.dart';

GetIt getIt = GetIt.asNewInstance();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp();
  print("Firebase Initialized");

  getIt.registerSingleton<ApiProvider>(ApiProvider());
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  SharedPreferences.setMockInitialValues({});

  Bloc.observer = SimpleBlocDelegate();
  UserRepository userRepository = UserRepository();
  await userRepository.initialize(); // Inicializa o UserRepository corretamente
  getIt.registerSingleton<AuthenticationBloc>(AuthenticationBloc(userRepository: userRepository));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return getIt.get<AuthenticationBloc>()..add(AppStarted());
          },
        ),
      ],
      child: RepositoryProvider(
        create: (context) => userRepository,
        child: Bontempo(),
      ),
    ),
  );
}

class Bontempo extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: getIt.get<AuthenticationBloc>(),
      listener: (BuildContext context, state) {
        if (state is AuthenticationUnauthenticated) {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            LoginViewRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: MaterialApp(
        title: 'Bontempo',
        onGenerateRoute: router.generateRoute,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: black,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
            ),
            BlocProvider<MovieGenresBloc>(
              create: (BuildContext context) => MovieGenresBloc(),
            ),
            BlocProvider<NewsCategoriesBloc>(
              create: (BuildContext context) => NewsCategoriesBloc(),
            ),
            BlocProvider<GastronomyTypesBloc>(
              create: (BuildContext context) => GastronomyTypesBloc(),
            ),
          ],
          child: SplashPage(),
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('pt'),
        ],
      ),
    );
  }
}
