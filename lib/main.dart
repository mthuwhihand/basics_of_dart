import 'package:basics_of_dart/data/datas_library.dart';
import 'package:basics_of_dart/data/local/local_database_interfaces/likes_datasource_interface.dart';
import 'package:basics_of_dart/data/local/local_database_interfaces/watchlist_datasource_interface.dart';
import 'package:basics_of_dart/models/repositories/repositories_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:basics_of_dart/viewmodels/blocs/blocs_library.dart';
import 'package:basics_of_dart/views/screens/home_screen.dart';
import 'package:basics_of_dart/views/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basics_of_dart/utils/colors.dart';
import 'package:isar/isar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //LocalDataSource
  final ILikesLocalDataSource likesLocalDataSource =
      SQLiteLikedLocalDataSource.instance;
  final IWatchlistLocalDataSource watchlistLocalDataSource =
      await IsarWatchlistLocalDataSource.getInstance();

  //Repositories
  final IAuthRepository authRepository = AuthRepository.instance;
  final IMovieRepository movieRepository = MovieRepository.instance;
  final ILikeRepository likeRepository =
      await LikeRepository.getInstance(likesLocalDataSource);
  final IWatchlistRepository watchlistRepository =
      await WatchlistRepository.getInstance(watchlistLocalDataSource);

  //Services
  final AuthService authService = await AuthService.getInstance(authRepository);
  final MovieService movieService = MovieService.getInstance(
      movieRepository, likeRepository, watchlistRepository);
  final LikeService likeService =
      LikeService.getInstance(likeRepository, movieService);
  final WatchlistService watchlistService =
      WatchlistService.getInstance(watchlistRepository, movieService);
  runApp(
    MyApp(
      authService: authService,
      movieService: movieService,
      likeService: likeService,
      watchlistService: watchlistService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final MovieService movieService;
  final LikeService likeService;
  final WatchlistService watchlistService;

  const MyApp({
    super.key,
    required this.authService,
    required this.movieService,
    required this.likeService,
    required this.watchlistService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authService: authService),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(movieService)..add(FetchMoviesEvent()),
        ),
        BlocProvider<LikeBloc>(
          create: (context) =>
              LikeBloc(likeService)..add(FetchLikedMoviesEvent()),
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) =>
              WatchlistBloc(watchlistService)..add(FetchWatchlistMoviesEvent()),
        ),
      ],
      child: MaterialApp(
        title: "Movies Exploring",
        theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          fontFamily: 'Fa',
          appBarTheme: const AppBarTheme(
            color: ColorPalette.backgroundScaffoldColor,
          ),
          scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white12,
            labelStyle: TextStyle(color: ColorPalette.primaryColor),
            hintStyle: TextStyle(color: ColorPalette.primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: AuthRepository.instance.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasData && snapshot.data!) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
