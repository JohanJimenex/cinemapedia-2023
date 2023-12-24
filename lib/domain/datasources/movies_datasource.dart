import 'package:cinemapedia/domain/entities/movie.dart';

//usamos una clase abstracta para definir las reglas que tendra quien implemente clase, que serian las impleemntacinoes de Datasources

// quien usa el datasource es el Repositorio
abstract class MoviesDataSource {
  //Se dfinen que metodos deben tener quienes implementen esta clase

  //pedimos peliculas en cartelera, acutales
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getTopRatedMovies({int page = 1});

  Future<List<Movie>> getUpComingMovies({int page = 1});

  Future<Movie> getMovieDetails(String movieId);

  Future<List<Movie>> searchMovie(String query);
}
