import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:basics_of_dart/viewmodels/blocs/blocs_library.dart';
import 'package:basics_of_dart/views/widgets/network_image_with_fallback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final String placeholderImage = 'assets/imgs/placeholder.jpg';

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieItemBloc(
        movie.id,
        context.read<LikeService>(),
        context.read<WatchlistService>(),
      ),
      child: BlocBuilder<MovieItemBloc, MovieItemState>(
        builder: (context, state) {
          return Card(
            child: Column(
              children: [
                NetworkImageWithFallback(
                  imageUrl: movie.posterURL,
                  placeholderAsset: placeholderImage,
                  height: 222,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                Text(movie.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        state is MovieItemLikeToggled
                            ? (state.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border)
                            : (movie.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border),
                        color: Colors.red,
                      ),
                      onPressed: () => context.read<MovieItemBloc>().add(
                          ToggleLikeEvent(state is MovieItemLikeToggled
                              ? state.isLiked
                              : movie.isLiked)),
                    ),
                    IconButton(
                      icon: Icon(
                        state is MovieItemWatchlistToggled
                            ? (state.isInWatchlist
                                ? Icons.bookmark
                                : Icons.bookmark_border)
                            : (movie.isInWatchlist
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                        color: Colors.blue,
                      ),
                      onPressed: () => context.read<MovieItemBloc>().add(
                          ToggleWatchlistEvent(
                              state is MovieItemWatchlistToggled
                                  ? state.isInWatchlist
                                  : movie.isInWatchlist)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
