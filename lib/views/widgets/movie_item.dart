import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:basics_of_dart/viewmodels/blocs/blocs_library.dart';
import 'package:basics_of_dart/viewmodels/blocs/movie_bloc/movie_bloc.dart';
import 'package:basics_of_dart/views/widgets/network_image_with_fallback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  final String placeholderImage = 'assets/imgs/placeholder.jpg';

  void _toggleLike(Movie movie) {
    // movie.isLiked = !movie.isLiked;
    context.read<MovieBloc>().add(ToggleLikeEvent(movie.id));
  }

  void _toggleWatchlist(Movie movie) {
    // movie.isInWatchlist = !movie.isInWatchlist;
    context.read<MovieBloc>().add(ToggleWatchlistEvent(movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          NetworkImageWithFallback(
            imageUrl: widget.movie.posterURL,
            placeholderAsset: placeholderImage,
            height: 222,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(widget.movie.title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: StreamBuilder<Movie>(
                    stream: context.read<MovieBloc>().movieStream,
                    initialData: widget.movie,
                    builder: (context, snapshot) {
                      final movie = snapshot.data!;
                      if (movie.id == widget.movie.id) {
                        return Icon(
                          movie.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        );
                      } else {
                        return Icon(
                          widget.movie.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        );
                      }
                    }),
                onPressed: () => _toggleLike(widget.movie),
              ),
              IconButton(
                icon: StreamBuilder<Movie>(
                    stream: context.read<MovieBloc>().movieStream,
                    initialData: widget.movie,
                    builder: (context, snapshot) {
                      final movie = snapshot.data!;
                      if (movie.id == widget.movie.id) {
                        return Icon(
                          movie.isInWatchlist
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.blue,
                        );
                      } else {
                        return Icon(
                          widget.movie.isInWatchlist
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.blue,
                        );
                      }
                    }),
                onPressed: () => _toggleWatchlist(widget.movie),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
