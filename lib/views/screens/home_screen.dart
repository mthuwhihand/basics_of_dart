import 'package:basics_of_dart/views/screens/likes_screen.dart';
import 'package:basics_of_dart/views/screens/movie_screen.dart';
import 'package:basics_of_dart/views/screens/rating_screen.dart';
import 'package:basics_of_dart/views/widgets/keep_alive_page_widget.dart';
import 'package:basics_of_dart/views/widgets/tabbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            bottom: const TabBarApp(),
          ),
          body: const TabBarView(
            children: <Widget>[
              KeepAlivePageWidget(page: MoviesScreen()),
              KeepAlivePageWidget(page: MoviesScreen()),
              KeepAlivePageWidget(page: MoviesScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
