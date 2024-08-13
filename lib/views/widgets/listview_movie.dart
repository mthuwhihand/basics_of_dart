import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/views/widgets/network_image_with_fallback.dart';
import 'package:flutter/material.dart';

class ListViewMovie extends StatefulWidget {
  const ListViewMovie({super.key, required this.items});
  final List<Movie>? items;

  @override
  _ListViewMovieState createState() => _ListViewMovieState(items: this.items);
}

class _ListViewMovieState extends State<ListViewMovie> {
  final List<Movie>? items;
  final String placeholderImage = 'assets/imgs/placeholder.jpg';
  _ListViewMovieState({required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items!.length,
      itemBuilder: (context, index) {
        final movie = items![index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 80.0),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                NetworkImageWithFallback(
                  // using NetworkImageWithFallback widget to handle image error
                  // when movie.posterURL is error url or not found image or other error
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
    );
  }
}
