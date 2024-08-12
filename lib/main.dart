import 'package:basics_of_dart/widgets/home_screen.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.black54,
        ),
        scaffoldBackgroundColor: Colors.black54,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
