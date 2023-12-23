import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieRepositoryProviderTemp = ref.watch(movieRepositoryProvider);

  return MoviesNotifier(
      fetchMoreMovies: movieRepositoryProviderTemp.getNowPlaying);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies =
      ref.watch(movieRepositoryProvider).getPopularMovies;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies =
      ref.watch(movieRepositoryProvider).getTopRatedMovies;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies =
      ref.watch(movieRepositoryProvider).getUpComingMovies;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//typedef es como una  un interface
typedef MovieCallback = Future<List<Movie>> Function({int page});

//Esto es exclusivo de RiverPod para manejar los estados de los providers, hay una alternativa
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool _isLoading = false;
  MovieCallback fetchMoreMovies;

  //se inicia con un arreglo vacio al menos que cargues previamente una data del localstorare
  //PEro en otra ocacion se pudiera poner una instancia de List<Movie>
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  // Aqui indicamos los casos de uso
  Future<void> loadNextPage() async {
    currentPage++;

    if (_isLoading) return;
    _isLoading = true;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // usando el 'ref' por parametros pero entonces solo podra usar este metodo con ese proveedor
    //state actualmente lo definimos con un arreglo vacio en el oncstructor con super()
    // state.addAll(movies);
    // agregamos un nuevo arreglo con spread operator, le emtoemos el que ya tiene , mas otro arreglo, , podemos agregar mas
    state = [...state, ...movies];

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
  }
}
