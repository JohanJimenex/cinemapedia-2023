//Este datasource es espeficio de para trabajar con The Mobie DB API
//Si se cambia la fuente de dato /API (datasource) entonces se crea otro archivoos
//Aqui se define el "Como" se obtiene la data para mmovieDB

import 'dart:async';
import 'dart:convert';

import 'package:cinemapedia/config/constant/endpoints.dart';
import 'package:cinemapedia/config/constant/enviroment_const.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details_repsonse.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:http/http.dart' as http;

class TheMovieDBDataSourceImpl extends MoviesDataSource {
  String urlBase = Enviroment.urlBaseMovieDB;

  @override // Para hacer polimorfismo
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    Uri url = Uri.https(urlBase, Endpoints.getMoviesOnCartelera, {
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

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    Uri url = Uri.https(urlBase, Endpoints.getPopularMovies, {
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

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    Uri url = Uri.https(urlBase, Endpoints.getTopRatedMovies, {
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

  @override
  Future<List<Movie>> getUpComingMovies({int page = 1}) async {
    Uri url = Uri.https(urlBase, Endpoints.getUpComingMovies, {
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

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    Uri url = Uri.https(
        urlBase,
        Endpoints.getMovieDetails.replaceFirst("{movieId}", movieId),
        {"api_key": Enviroment.theMovieDBAPIKey, "language": "es-MX"});

    final resp = await http.get(url);
    // if code != 200 navegar a otra ruta, ?
    final Map<String, dynamic> respJson = json.decode(resp.body);

    final MovieDetailsResponse movieDetails =
        MovieDetailsResponse.fromJson(respJson);
    final Movie movie =
        MovieMapper.movieDBDetailsModelToEntity(movieDetails);

    return movie;
  }

  late Timer timer = Timer(Duration.zero, () {});

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (timer.isActive) {
      timer.cancel();
    }

    Uri url = Uri.https(urlBase, Endpoints.searchMovies, {
      "api_key": Enviroment.theMovieDBAPIKey,
      "language": "es-MX",
      "query": query
    });

    Completer<List<Movie>> listMovieDbCompleter = Completer<List<Movie>>();

    timer = Timer(const Duration(milliseconds: 700), () async {
      final resp = await http.get(url);
      final respJson = json.decode(resp.body);
      final movieDbResponse = MovieDbResponse.fromJson(respJson);
      final listMovieDb = movieDbResponse.results
          // .where((movieDb) => movieDb.adult != true)
          .map((e) => MovieMapper.movieDBModelToEntity(e))
          .toList();
      listMovieDbCompleter.complete(listMovieDb);
    });

    return listMovieDbCompleter.future;
  }
}
