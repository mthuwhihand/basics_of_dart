import 'package:basics_of_dart/views/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewmodels/blocs/like_bloc/like_bloc.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch initial liked movies
    context.read<LikeBloc>().add(FetchLikedMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeBloc, LikeState>(
      builder: (context, state) {
        if (state is LikeLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LikedMoviesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<LikeBloc>().add(FetchLikedMoviesEvent());
            },
            child: ListView.builder(
              // controller: _scrollController,
              itemCount: state.likedMovies.length,
              itemBuilder: (context, index) {
                final movie = state.likedMovies[index];
                return MovieItem(movie: movie);
              },
            ),
          );
        } else if (state is LikeError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No liked movies available'));
      },
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
}
