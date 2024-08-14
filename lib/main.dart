import 'package:basics_of_dart/repositories/auth_repository.dart';
import 'package:basics_of_dart/utils/colors.dart';
import 'package:basics_of_dart/utils/setup_locator.dart';
import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_bloc.dart';
import 'package:basics_of_dart/views/screens/home_screen.dart';
import 'package:basics_of_dart/views/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  // setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          authRepository:
              AuthRepository.instance /*GetIt.instance<AuthRepository>()*/),
      child: MaterialApp(
        title: "Movies Exploring",
        theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
