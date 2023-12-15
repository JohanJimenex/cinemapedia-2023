import 'movie_moviedb.dart';

//Recuerda que no queremos que nuestra app se base en este modelo, porque puede cambiar, queremos usar el nuestro Entity
class MovieDbResponse {
  //Esta clase es para la respuesta, es como crear una interfaz para las respuestas en Angular pero yo usualmente no creo interfaces para respuesta
  //Sino que mando el resp.result por ejemplo. Creamos otro modelo/class para los que en vdd nos importa que es el result, llamada MovieMovieDB

  //Hicimos esta propiedad opcional porque vamos a usar este modelo para todas las repuestas de MovieDB que se parecen todas,
  //Pero a veces viene o no la propiedad DATE
  final Dates? dates;
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

//factory consturctor es un constructor extra, para pdoer usarlo así:  MovieDbResponse().nombreMetodo() y que devuelva el objeto
//convierte un json a un objeto de un objeto del tipo de esta clase "MovieDbRespone"
//tambien se puede mandar el objeto y hace run mapeo manual con el constructor
//La idea es tener varios conversores por si la respuesta pudiera venir en un XML u otro formato
  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        //Validamos este campo porque la respuesta de moviebd la mayoria son iguales lo unico que a veces tienen el campo DATE y otras respuesta sno
        //La hicimos opcional arriba
        dates:
            json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(
            json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
