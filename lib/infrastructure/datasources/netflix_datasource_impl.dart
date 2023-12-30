//Aqui se crrea la implementacion para consumir los servicios de netfliex

//Este datasource es espeficio de para trabajar con The Mobie DB API
//Si se cambia la fuente de dato /API (datasource) entonces se crea otro archivoos
//Aqui se define el "Como" se obtiene la data para mmovieDB

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/video.dart';

// import 'dart:convert';
// import 'package:cinemapedia/config/constant/endpoints.dart';
// import 'package:cinemapedia/config/constant/enviroment_const.dart';
// import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
// import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
// import 'package:http/http.dart' as http;

class NetflixDatasource extends MoviesDataSource {
  // String urlBase = Enviroment.urlBaseNetflix;

  @override // Para hacer polimorfismo
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Uri url = Uri.https(urlBase, Endpoints.getMovie,
    //     {"api_key": Enviroment.netflixAPIKey});

    // final resp = await http.get(url);
    // final respJson = json.decode(resp.body);
    // final netflixResponse = NetflixResponse.fromJson(respJson);
    // final List<Movie> listMovieDb = netflixResponse.results
    //     // .where((movie) => movie.adult != true)
    //     .map((e) => MovieMapper.movieNetflixModelToEntity(e))
    //     .toList();

    // return listMovieDb;
    return [];
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    //   implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    //  implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getUpComingMovies({int page = 1}) {
    //   implement getUpComingMovies
    throw UnimplementedError();
  }

  @override
  Future<Movie> getMovieDetails(String movieId) {
    //   implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    throw UnimplementedError();
  }

  @override
  Future<List<Video>> getYoutubeVideosByMovieId(String movieId) {
    // TODO: implement getYoutubeVideosByMovieId
    throw UnimplementedError();
  }
}
