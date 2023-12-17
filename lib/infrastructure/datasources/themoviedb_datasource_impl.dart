//Este datasource es espeficio de para trabajar con The Mobie DB API
//Si se cambia la fuente de dato /API (datasource) entonces se crea otro archivoos
//Aqui se define el "Como" se obtiene la data para mmovieDB

import 'dart:convert';

import 'package:cinemapedia/config/constant/endpoints.dart';
import 'package:cinemapedia/config/constant/enviroment_const.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:http/http.dart' as http;

class TheMovieDBDataSourceImpl extends MoviesDataSource {
  String urlBase = Enviroment.urlBaseMovieDB;

  @override // Para hacer polimorfismo
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    Uri url = Uri.https(urlBase, Endpoints.getMovie, {
      "api_key": Enviroment.theMovieDBAPIKey,
      "language": "es-MX",
      "page": page.toString()
    });

    final resp = await http.get(url);
    final respJson = json.decode(resp.body);
    final movieDbResponse = MovieDbResponse.fromJson(respJson);
    final List<Movie> listMovieDb = movieDbResponse.results
        // .where((movieDb) => movieDb.adult != true)
        .map((e) => MovieMapper.movieDBModelToEntity(e))
        .toList();

    return listMovieDb;
  }
}
