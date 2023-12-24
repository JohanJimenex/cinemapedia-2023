import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/actors/actors_horizontal_listview.dart';
import 'package:cinemapedia/providers/actors/actors_provider.dart';
import 'package:cinemapedia/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final moviesMap = ref.watch(movieDetailsProvider);
    final Movie? movie = moviesMap[widget.movieId];

    //rerotna en el State un mapa con todas los actores consultados
    final actorsList = ref.watch(actorsProvider)[widget.movieId];

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

class _SliverAppBar extends StatelessWidget {
  final Movie? movie;

  const _SliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      // expandedHeight: screenSize.height / 1.5,
      expandedHeight: screenSize.height * 0.65,
      foregroundColor: Colors.white, //color para la flechita
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        background: movie!.posterPath == ""
            ? Image.asset("assets/images/no-image-poster.png")
            : Image.network(movie!.posterPath),
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
              child: Center(child: Text(movie!.title)),
            ),
          ),
        ]),
        centerTitle: true,
      ),
    );
  }
}
