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
}
