import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_bloc.dart';
import 'package:basics_of_dart/views/screens/likes/likes_screen.dart';
import 'package:basics_of_dart/views/screens/movie/movie_screen.dart';
import 'package:basics_of_dart/views/screens/watchlist/watchlist_screen.dart';
import 'package:basics_of_dart/views/widgets/keep_alive_page_widget.dart';
import 'package:basics_of_dart/views/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            title: const Text(
              'Home',
              style: TextStyle(fontFamily: 'Fa', fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Log out',
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(const AuthLogoutRequestedEvent());
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
            bottom: const TabBarApp(),
          ),
          body: const TabBarView(
            children: <Widget>[
              KeepAlivePageWidget(page: MoviesScreen()),
              LikedScreen(),
              WatchlistScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
