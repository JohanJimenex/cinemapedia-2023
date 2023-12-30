import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
import 'package:cinemapedia/presentation/widgets/movies/youtube_player.dart';
import 'package:cinemapedia/providers/localdb/favorites_movies_provider.dart';
import 'package:cinemapedia/providers/localdb/is_favorite_movie_provider.dart';
import 'package:cinemapedia/providers/localdb/localdb_repository_provider.dart';
import 'package:cinemapedia/providers/movies/videoyt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
import 'package:cinemapedia/presentation/widgets/actors/actors_horizontal_listview.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  static const String nameOfScreen = "MovieDetailsScreen";

  final String movieId;
  // final Movie movie; //se puede recibir el movie pero no funcionaria para la web,

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsProvider.notifier).getActorsByMovies(widget.movieId);
    // ref.read(videoYTProvider(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final moviesMap = ref.watch(movieDetailsProvider);
    final Movie? movie = moviesMap[widget.movieId];

    //rerotna en el State un mapa con todas los actores consultados
    final actorsList = ref.watch(actorsProvider)[widget.movieId];
    final video = ref.watch(videoYTProvider(widget.movieId));

    if (movie == null || actorsList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _SliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomBadge(text: movie.adult ? "18+" : "7+"),
                      const CustomBadge(text: "HD"),
                      const CustomBadge(text: "CC"),
                      CustomBadge(text: movie.originalLanguage),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${movie.releaseDate.toIso8601String().substring(0, 4)} • "),
                      ...movie.genreIds.map(
                        (e) => Text(
                          "$e, ",
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(movie.overview == ""
                        ? "No hay descripción"
                        : movie.overview),
                  ),
                  video.when(data: (resp) {
                    return YoutubeVideoPlayer(listVideos: resp);
                  }, error: (_, __) {
                    return const Text("Error al cargar el trailer");
                  }, loading: () {
                    return const Text("Cargando trailer...");
                  }),
                  ActorListView(actorsList: actorsList),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}

class CustomBadge extends StatelessWidget {
  final String text;

  const CustomBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 25,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white24,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _SliverAppBar extends ConsumerStatefulWidget {
  final Movie? movie;

  const _SliverAppBar({required this.movie});

  @override
  _SliverAppBarState createState() => _SliverAppBarState();
}

class _SliverAppBarState extends ConsumerState<_SliverAppBar> {
  late bool isFavorite;

  @override
  void initState() {
    checkIfMovieIsInFavorite();
    super.initState();
  }

  checkIfMovieIsInFavorite() async {
    final bool resp = await ref
        .read(localDBRepositoryProvider)
        .isMovieInFavorite(widget.movie!.id);

    ref.read(isFavoriteMovieProvider.notifier).state = resp;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;
    bool isFavorite = ref.watch(isFavoriteMovieProvider);

    return SliverAppBar(
      actions: [
        Ink(
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: isFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
            color: Colors.white,
            onPressed: () async {
              await ref
                  .read(localDBRepositoryProvider)
                  .toggleFavorite(widget.movie!);

              final bool isFavorite = await ref
                  .read(localDBRepositoryProvider)
                  .isMovieInFavorite(widget.movie!.id);

              ref.read(isFavoriteMovieProvider.notifier).state =
                  isFavorite;

              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .updateFavoritesMovies();
            },
          ),
        )
      ],
      backgroundColor: Colors.black,
      // expandedHeight: screenSize.height / 1.5,
      expandedHeight: screenSize.height * 0.65,
      foregroundColor: Colors.white, //color para la flechita
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        background: widget.movie!.posterPath == ""
            ? Image.asset("assets/images/no-image-poster.png")
            : Image.network(widget.movie!.posterPath),
        expandedTitleScale: 1,
        title: Stack(alignment: Alignment.bottomCenter, children: [
          const SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0, 0.3],
                        end: Alignment.center,
                        colors: [Colors.black, Colors.transparent]))),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(0, 0.9),
                      end: Alignment(0, 0),
                      colors: [Colors.black87, Colors.black45])),
              child: Center(
                  child: Text(
                widget.movie!.title,
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ]),
        centerTitle: true,
      ),
    );
  }
}
