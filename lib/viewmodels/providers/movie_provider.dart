import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../../repositories/movie_repository.dart';


class MovieProvider with ChangeNotifier {
  final MovieRepository movieRepository;

  List<Movie> _movies = [];
  bool _isLoading = false;
  bool _hasMoreMovies = true;
  int _currentPage = 1;
  final int _pageSize = 10;

  List<Movie>? get movies => _movies;
  bool get isLoading => _isLoading;
  bool get hasMoreMovies => _hasMoreMovies;

  MovieProvider({required this.movieRepository});

  Future<void> fetchMovies({required String type, bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _hasMoreMovies = true;
      _movies.clear();
    }

    _isLoading = true;
    notifyListeners();

    final response = await movieRepository.fetchMovies(type: type);

    if (response.status == HttpStatus.ok) {
      List<Movie> fetchedMovies = response.data!;

      if (fetchedMovies.length < _pageSize) {
        _hasMoreMovies = false;
      }

      _movies.addAll(fetchedMovies.take(_pageSize));
    } else {
      _hasMoreMovies = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreMovies(String type) async {
    if (_hasMoreMovies) {
      _currentPage++;
      await fetchMovies(type: type);
    }
  }

  Future<void> refreshMovies(String type) async {
    await fetchMovies(type: type, refresh: true);
  }

}
