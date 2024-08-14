import 'package:basics_of_dart/repositories/movie_repository.dart';
import 'package:basics_of_dart/views/widgets/movie_searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../viewmodels/blocs/movie_bloc/movie_bloc.dart';
import '../../viewmodels/blocs/movie_bloc/movie_event.dart';
import '../../viewmodels/blocs/movie_bloc/movie_state.dart';
import '../widgets/network_image_with_fallback.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});
  final String type = 'animation';
  final String placeholderImage = 'assets/imgs/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
          movieRepository: /*MovieRepository()*/
              GetIt.instance<MovieRepository>())
        ..add(FetchMovies(type)),
      child: Scaffold(
        appBar: AppBar(
          title: MovieSearchBar(type: type),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 20.0,
              ));
            } else if (state is MovieLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MovieBloc>().add(RefreshMovies(type));
                },
                child: ListView.builder(
                  itemCount: state.movies.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.movies.length) {
                      if (context.read<MovieBloc>().hasMoreMovies) {
                        context.read<MovieBloc>().add(LoadMoreMovies(type));
                        return const Center(
                            child: CupertinoActivityIndicator(
                          radius: 20.0,
                        ));
                      } else {
                        return const Center(
                          child: Text(
                            '- That\'s all -',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      }
                    }
                    final movie = state.movies[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 80.0),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            NetworkImageWithFallback(
                              imageUrl: movie.posterURL,
                              placeholderAsset: placeholderImage,
                              height: 222,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 12.0),
                            Center(
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is MovieError) {
              return Center(child: Text('${state.message}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
