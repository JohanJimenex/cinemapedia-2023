import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actor_movieddb_response.dart';

class ActorMapper {
  static Actor actorMovieDBModelToEntity(Cast cast) {
    Actor actor = Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? "https://image.tmdb.org/t/p/w500/${cast.profilePath}"
          : "",
      character: cast.character,
      gender: cast.gender == 1 ? "Femenino" : "Masculino",
      roll: cast.job,
    );

    return actor;
  }
}
