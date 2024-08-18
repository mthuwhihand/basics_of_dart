import 'package:basics_of_dart/views/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewmodels/blocs/watchlist_bloc/watchlist_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch initial watchlist movies
    context.read<WatchlistBloc>().add(FetchWatchlistMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is WatchlistMoviesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<WatchlistBloc>().add(FetchWatchlistMoviesEvent());
            },
            child: ListView.builder(
              // controller: _scrollController,
              itemCount: state.watchlistMovies.length,
              itemBuilder: (context, index) {
                final movie = state.watchlistMovies[index];
                return MovieItem(movie: movie);
              },
            ),
          );
        } else if (state is WatchlistError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No movies in watchlist'));
      },
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
}
