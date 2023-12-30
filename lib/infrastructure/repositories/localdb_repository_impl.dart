import 'package:cinemapedia/domain/datasources/localdb_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/localdb_repository.dart';

class LocalDBRepositoryImpl extends LocalDBRepository {
  final LocalDBDataSource dataSource;

  LocalDBRepositoryImpl({required this.dataSource});

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }

  @override
  Future<bool> isMovieInFavorite(int movieId) {
    return dataSource.isMovieInFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 20, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }
}
