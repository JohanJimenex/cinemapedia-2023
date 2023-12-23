import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepositoryProviderTemp = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(
      getMovie: movieRepositoryProviderTemp.getMovieDetails);
});

// {
//   "id1234": Movie(),
//   "id1234": Movie(),
//   "id1234": Movie(),
//   "id1234": Movie(),
//   "id1234": Movie(),
// }

typedef GetMovieCallback = Future<Movie> Function(String movieId);

//Especificamos el tipado del state, en este caso un Map<String, Movie>
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    //es un mapa, en el otro es un arreglo
    state = {...state, movieId: movie};
  }
}
