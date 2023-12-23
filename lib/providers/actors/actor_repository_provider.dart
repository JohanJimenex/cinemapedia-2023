import 'package:cinemapedia/infrastructure/datasources/actors_moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este es el provider padre y base para crear una capa de atrabscacion por si cambia el datasource en un futuro
//Solo es cambiarlo aqui
final actorRepositoryProvider = Provider((ref) =>
    ActorRepositoryImpl(actorsDataSource: ActorsMovieDbDatasourceImpl()));
