import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

//El reposotirio es quein llama al Datasource
// porque en el repositorio podemos cambiar el datasource

//usamos una clase abstracta para definir las reglas que tendra quien implemente clase, que serian las impleemntacinoes de Datasources
abstract class MoviesRepository {
  //Se dfinen que metodos deben tener quienes implementen esta clase

  //peidmos peliculas en cartelera, acutales
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getTopRatedMovies({int page = 1});

  Future<List<Movie>> getUpComingMovies({int page = 1});

  Future<Movie> getMovieDetails(String movieId);

  Future<List<Movie>> searchMovie(String query);

  Future<List<Video>> getYoutubeVideosByMovieId(String movieId);
}
