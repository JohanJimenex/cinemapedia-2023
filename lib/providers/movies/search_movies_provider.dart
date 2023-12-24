import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final moviesProviderTemp = ref.watch(movieRepositoryProvider);

  return SearchMoviesNotifier(
      callBackSeachMovie: moviesProviderTemp.searchMovie);
});

typedef CallBackSeachMovie = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  CallBackSeachMovie callBackSeachMovie;

  SearchMoviesNotifier({required this.callBackSeachMovie}) : super([]);

  Future<void> seatchMovies(String query) async {
    final List<Movie> resp = await callBackSeachMovie(query);

    state = [...state, ...resp];
  }
}
