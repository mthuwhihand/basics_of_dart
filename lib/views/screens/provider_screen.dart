import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repositories/movie_repository.dart';
import '../../viewmodels/providers/movie_provider.dart';
import '../widgets/network_image_with_fallback.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});
  final String type = 'comedy';
  final String placeholderImage = 'assets/imgs/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(movieRepository: MovieRepository())..fetchMovies(type: type),
      child: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading && movieProvider.movies!.isEmpty) {
            return const Center(child: CupertinoActivityIndicator(radius: 20.0,));
          } else if (!movieProvider.isLoading && movieProvider.movies!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return RefreshIndicator(
              onRefresh: () => movieProvider.refreshMovies(type),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: movieProvider.movies!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == movieProvider.movies!.length) {
                          if (movieProvider.hasMoreMovies) {
                            movieProvider.loadMoreMovies(type);
                            return const Center(child: CupertinoActivityIndicator(radius: 20.0,));
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

                        final movie = movieProvider.movies![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 80.0),
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
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}