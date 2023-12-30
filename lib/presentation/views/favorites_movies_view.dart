import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:cinemapedia/providers/localdb/favorites_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMoviesView extends ConsumerStatefulWidget {
  const FavoriteMoviesView({super.key});

  @override
  FavoriteMoviesViewState createState() => FavoriteMoviesViewState();
}

class FavoriteMoviesViewState extends ConsumerState<FavoriteMoviesView> {
  @override
  void initState() {
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesProvider);
    final loadNextPageCallBack =
        ref.watch(favoriteMoviesProvider.notifier).loadNextPage;

    return Scaffold(
        body: movies.isEmpty
            ? const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 10),
                      Text("No hay peliculas favoritas")
                    ]),
              )
            : MovieMasonry(
                listMovies: movies, loadNextPage: loadNextPageCallBack));
  }
}
