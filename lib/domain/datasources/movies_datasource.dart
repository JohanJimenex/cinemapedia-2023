import 'package:cinemapedia/domain/entities/movie.dart';

//usamos una clase abstracta para definir las reglas que tendra quien implemente clase, que serian las impleemntacinoes de Datasources

// quien usa el datasource es el Repositorio
abstract class MovieDataSource {
  //Se dfinen que metodos deben tener quienes implementen esta clase

  //pedimos peliculas en cartelera, acutales
  Future<List<Movie>> getNowPlaying({int page = 1});
}
