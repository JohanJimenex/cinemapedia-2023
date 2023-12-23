import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  //Fuente de datos que esperamos recibir, el tipo es generico
  final MoviesDataSource dataSource;

  //Aqui tienen que enviarme el data source a utiizar
  //que puede ser movieDBDatasource, NetflixDatasource, etc,
  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    // Hacemos la peticion es a traves del datasource utilizado, y retornamos el resultado
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return dataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    return dataSource.getTopRatedMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpComingMovies({int page = 1}) {
    return dataSource.getUpComingMovies(page: page);
  }

  @override
  Future<Movie> getMovieDetails(String movieId) {
    return dataSource.getMovieDetails(movieId);
  }
}
