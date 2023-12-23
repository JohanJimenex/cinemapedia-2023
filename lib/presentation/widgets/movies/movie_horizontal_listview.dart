import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadMoreMovies;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadMoreMovies});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState
    extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  bool loadMore = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadMoreMovies == null) return;
      final livePositionScroll = scrollController.position.pixels;
      final endPositionScroll = scrollController.position.maxScrollExtent;
      if (livePositionScroll + 200 > endPositionScroll) {
        // loadMore = false;
        widget.loadMoreMovies!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final colorsTheme = Theme.of(context).colorScheme;

    return widget.movies.isEmpty
        ? const CircularProgressIndicator()
        : SizedBox(
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie movie = widget.movies[index];

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // context.push("/movieDetailsScreen/${movie.id}", extra: movie); //enviar objeto
                          context.push("/movieDetailsScreen/${movie.id}");
                        },
                        child: SizedBox(
                          width: 150,
                          height: 200,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: movie.posterPath == ""
                                  ? Image.asset(
                                      "assets/images/no-image.jpeg",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      movie.posterPath,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child,
                                          loadingProgress) {
                                        if (loadingProgress != null) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        return child;
                                      },
                                    )),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          movie.title,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_half_rounded,
                              color: Colors.amber,
                            ),
                            Text(
                              movie.voteAverage.toStringAsFixed(2),
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.amber[700]),
                            ),
                            const Spacer(),
                            Text(shortNumberToK(movie.popularity))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}

String shortNumberToK(double valor) {
  if (valor >= 1000) {
    double valorEnK = valor / 1000;
    return '${valorEnK.toStringAsFixed(2)}k';
  } else {
    return valor.toStringAsFixed(2);
  }
}
