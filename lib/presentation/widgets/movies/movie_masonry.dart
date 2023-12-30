import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> listMovies;
  //Se recibe el metodo para hacer este widget reutilizable para otras peliculas que no sean favoritas
  final VoidCallback? loadNextPage;

  const MovieMasonry(
      {super.key, required this.listMovies, required this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      final actualPosition = scrollController.position.pixels;
      final maxPosition = scrollController.position.maxScrollExtent;
      if (actualPosition + 200 >= maxPosition) {
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.listMovies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = widget.listMovies[index];

          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                _InteractivePosterImage(movie: movie)
              ],
            );
          }

          return _InteractivePosterImage(movie: movie);
        });
  }
}

class _InteractivePosterImage extends StatelessWidget {
  const _InteractivePosterImage({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/movieDetailsScreen/${movie.id}");
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage.assetNetwork(
              fadeInDuration: const Duration(seconds: 3),
              fadeInCurve: Curves.linear,
              placeholder: "assets/images/no-image-poster.png",
              image: movie.posterPath)),
    );
  }
}
