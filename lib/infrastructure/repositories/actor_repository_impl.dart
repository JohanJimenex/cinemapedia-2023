import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl implements ActorsRepository {
  ActorsDatasource actorsDataSource;

  ActorRepositoryImpl({required this.actorsDataSource});

  @override
  Future<List<Actor>> getActorsByMovies(String movieId) {
    return actorsDataSource.getActorsByMovies(movieId);
  }
}
