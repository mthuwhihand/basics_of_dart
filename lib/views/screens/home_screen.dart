import 'dart:io';

import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';
import 'package:basics_of_dart/repositories/movie_dio.dart';
import 'package:basics_of_dart/repositories/movie_http.dart';
import 'package:basics_of_dart/views/widgets/listview_movie.dart';
import 'package:basics_of_dart/views/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DIOMovieRepository dioMovieRepository = DIOMovieRepository();
    HTTPMovieRepository httpMovieRepository = HTTPMovieRepository();
    const String typeMovie = 'animation';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            bottom: const TabBarApp(),
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder<ApiResponse<List<Movie>>>(
                future: dioMovieRepository.fetchMovies(type: typeMovie),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError ||
                      snapshot.data?.status ==
                          HttpStatus.networkConnectTimeoutError) {
                    return Center(
                        child: Text('Error: ${snapshot.data?.message}'));
                  } else if (snapshot.data?.status == HttpStatus.ok) {
                    return ListViewMovie(items: snapshot.data!.data);
                  } else {
                    return const Center(child: Text('No movies found'));
                  }
                },
              ),
              FutureBuilder<ApiResponse<List<Movie>>>(
                future: httpMovieRepository.fetchMovies(type: typeMovie),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError ||
                      snapshot.data?.status ==
                          HttpStatus.networkConnectTimeoutError) {
                    return Center(
                        child: Text('Error: ${snapshot.data?.message}'));
                  } else if (snapshot.data?.status == HttpStatus.ok) {
                    return ListViewMovie(items: snapshot.data!.data);
                  } else {
                    return const Center(child: Text('No movies found'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
