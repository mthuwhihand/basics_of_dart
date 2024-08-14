import 'package:basics_of_dart/repositories/movie_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository());
  // Register other dependencies similarly
}
