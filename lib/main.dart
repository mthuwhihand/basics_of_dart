import 'package:basics_of_dart/repositories/auth_repository.dart';
import 'package:basics_of_dart/utils/colors.dart';
import 'package:basics_of_dart/utils/setup_locator.dart';
import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_bloc.dart';
import 'package:basics_of_dart/views/screens/home_screen.dart';
import 'package:basics_of_dart/views/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository.instance),
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
