import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/actors/actor_repository_provider.dart';
// import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
// import 'package:cinemapedia/infrastructure/datasources/actors_moviedb_datasource_impl.dart';

final actorsProvider =
    StateNotifierProvider<ActorNotifier, Map<String, List<Actor>>>((ref) {
  //se creo en un arrchivo apaerte para buena practica y capa de abstraccion
  // final repositorioImpl = ActorRepositoryImpl(
  //   actorsDataSource: ActorsMovieDbDatasourceImpl(),
  // );
  // return ActorNotifier(getActors: repositorioImpl.getActorsByMovies);

  final actorRepositoryProviderTemp = ref.watch(actorRepositoryProvider);
  return ActorNotifier(
      getActors: actorRepositoryProviderTemp.getActorsByMovies);
});

typedef CallBackGetActor = Future<List<Actor>> Function(String movieId);

//Guarda en el estado un mapa <String, Lista<Actor>> con todas los actores consultados
class ActorNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final CallBackGetActor getActors;

  //iniciamos con un mapa vacio
  ActorNotifier({required this.getActors}) : super({});

  Future<dynamic> getActorsByMovies(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actorList = await getActors(movieId);
    //Guarda en el estado un mapa <String, Lista<Actor>> con todas los actores consultados
    state = {...state, movieId: actorList};
  }
}
