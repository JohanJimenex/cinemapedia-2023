import 'dart:convert';

import 'package:cinemapedia/config/constant/endpoints.dart';
import 'package:cinemapedia/config/constant/enviroment_const.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actor_movieddb_response.dart';
import 'package:http/http.dart' as http;

class ActorsMovieDbDatasourceImpl implements ActorsDatasource {
  final String urlBase = Enviroment.urlBaseMovieDB;

  @override
  Future<List<Actor>> getActorsByMovies(String movieId) async {
    final Uri url = Uri.https(
      urlBase,
      Endpoints.getActorsByMovie.replaceFirst("{movieId}", movieId),
      {"api_key": Enviroment.theMovieDBAPIKey},
    );

    final request = await http.get(url);
    final jsonRepsonse = await jsonDecode(request.body);
    final ActorMovieDBResponse actorResponse =
        ActorMovieDBResponse.fromJson(jsonRepsonse);

    final List<Actor> actors = actorResponse.cast
        .map((e) => ActorMapper.actorMovieDBModelToEntity(e))
        .toList();
    return actors;
  }
}
