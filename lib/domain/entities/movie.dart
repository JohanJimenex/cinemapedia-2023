//Esta son mis reglas de negocio , las propeidades con las que YO quiero trabajar
//Si la API X no tiene algunas de estas propiedades pues se manejaran como opcional o algun dato por defecto
//Se hace con el fin de que si el API cambia algunas propiedades solo hay que cambiarla en el mapper que usa/mapea esta clase
// ejemplo: si en la repsuesta de la API viene "forAdult" en vex de "adult" pues con el mapper lo mapeamos
class Movie {
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});
}
