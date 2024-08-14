import 'package:basics_of_dart/viewmodels/blocs/movie_bloc/movie_bloc.dart';
import 'package:basics_of_dart/viewmodels/blocs/movie_bloc/movie_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchBar extends StatefulWidget {
  const MovieSearchBar({super.key, required this.type});
  final String type;

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  bool isDark = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<MovieBloc>().setSearchQuery(type: widget.type, query: '');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search movies...',
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearSearch,
              )
            : null,
      ),
      onChanged: (String query) {
        // Handle search query change
        context
            .read<MovieBloc>()
            .setSearchQuery(type: widget.type, query: query);
      },
      onSubmitted: (String query) {
        // Handle search submission
        context.read<MovieBloc>().add(SearchMovies(widget.type, query));
      },
    );
  }
}
