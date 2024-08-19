import 'package:basics_of_dart/viewmodels/blocs/blocs_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewmodels/blocs/movie_bloc/movie_bloc.dart';
import '../../widgets/movie_item.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    // Fetch initial movies
    context.read<MovieBloc>().add(FetchMoviesEvent());
  }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // Load more movies when reaching the end of the list
  //     if (context.read<MovieBloc>().hasMoreMovies) {
  //       context.read<MovieBloc>().add(const LoadMoreMovieEvent());
  //     }
  //   }

  @override
  void didUpdateWidget(covariant MoviesScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void activate() {
    // TODO: implement activate
    super.activate();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is MoviesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MovieBloc>().add(const RefreshMovieEvent());
            },
            child: ListView.builder(
              // controller: _scrollController,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                if (index == state.movies.length) {
                  if (context.read<MovieBloc>().hasMoreMovies) {
                    context.read<MovieBloc>().add(const LoadMoreMovieEvent());
                    return const Center(
                        child: CupertinoActivityIndicator(
                      radius: 20.0,
                    ));
                  } else {
                    return const Text(
                      '- That\'s all -',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  }
                }
                final movie = state.movies[index];
                return MovieItem(movie: movie);
              },
            ),
          );
        } else if (state is MoviesError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No movies available'));
      },
    );
  }

  // @override
  // void dispose() {
  //   // _scrollController.dispose();
  //   super.dispose();
  // }
}
