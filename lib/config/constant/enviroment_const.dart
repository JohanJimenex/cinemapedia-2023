import 'package:flutter_dotenv/flutter_dotenv.dart';

//Esto es solo para poder usar la connotacion con el punto . eje: .Propiedad
class Enviroment {
  static String theMovieDBAPIKey =
      dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No hay API Key";
  static String urlBaseMovieDB =
      dotenv.env["URL_BASE_MOVIEDB"] ?? "No hay URL Base";
}
