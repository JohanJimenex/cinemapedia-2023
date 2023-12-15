import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//typedef
typedef MovieCallback = Future<List<Movie>> Function({int page});

//Esto es exclusivo de RiverPod para manejar los estados de los providers, hay una alternativa
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  //se inicia con un arreglo vacio al menos que cargues previamente una data del localstorare
  //PEro en otra ocacion se pudiera poner una instancia de List<Movie>
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  // Aqui indicamos los casos de uso
  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    // usando el 'ref' por parametros pero entonces solo podra usar este metodo con ese proveedor
    //state actualmente lo definimos con un arreglo vacio en el oncstructor con super()
    // state.addAll(movies);
    state = [...state, ...movies]; //ni puta idea T.T
  }
}
