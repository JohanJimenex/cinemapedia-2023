import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/localdb/localdb_repository_provider.dart';
import 'package:cinemapedia/infrastructure/repositories/localdb_repository_impl.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, List<Movie>>((ref) {
  final localDbRepository = ref.watch(localDBRepositoryProvider);

  return FavoriteMoviesNotifier(localDbRepository: localDbRepository);
});

class FavoriteMoviesNotifier extends StateNotifier<List<Movie>> {
  int offset = 0;

  LocalDBRepositoryImpl localDbRepository;

  FavoriteMoviesNotifier({required this.localDbRepository}) : super([]);

  Future<void> loadNextPage() async {
    final movies = await localDbRepository.loadMovies(offset: offset);
    offset = offset + 20;

    state = [...state, ...movies];
  }

  Future<void> updateFavoritesMovies() async {
    // final movies = await localDbRepository.loadMovies();
    //esto remueve un objeto si usaramos objetos en el estado o recibimos parametro en el meotod
    // state.remove(value); mas detalles en el video de fernando
    // state = [...movies];

    offset = 0;
    state.clear();

    loadNextPage();
  }
}
