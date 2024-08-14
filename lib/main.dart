import 'package:basics_of_dart/utils/colors.dart';
import 'package:basics_of_dart/utils/setup_locator.dart';
import 'package:basics_of_dart/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies Exploring",
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
