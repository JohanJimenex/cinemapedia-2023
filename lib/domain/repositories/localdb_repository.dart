import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalDBRepository {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieInFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 20, offset = 0});
}
