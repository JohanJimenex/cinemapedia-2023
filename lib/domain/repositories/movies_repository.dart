import 'package:cinemapedia/domain/entities/movie.dart';

//El reposotirio es quein llama al Datasource
// porque en el repositorio podemos cambiar el datasource

//usamos una clase abstracta para definir las reglas que tendra quien implemente clase, que serian las impleemntacinoes de Datasources

abstract class MovieDataRepository {
  //Se dfinen que metodos deben tener quienes implementen esta clase

  //peidmos peliculas en cartelera, acutales
  Future<List<Movie>> getNowPlaying({int page = 1});
}
