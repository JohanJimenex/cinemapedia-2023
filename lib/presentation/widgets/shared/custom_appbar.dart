import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
// import 'package:cinemapedia/providers/movies/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  static String lastQuery = "";
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    // final movieRepository = ref.read(movieRepositoryProvider);
    // final movieRepository = ref.watch(searchMoviesProvider.notifier).seatchMovies;

    return SliverAppBar(
      floating: true,
      // flexibleSpace: FlexibleSpaceBar(
      //   title: CustomAppbar(),
      // ),
      leading: Icon(Icons.movie_creation_outlined, color: colors.primary),
      title: Row(
        children: [
          Text(
            "Cinemapedia",
            style: textStyle.titleLarge,
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              // context.push("/TestScreen");
              // context.go("/TestScreen");
              // ref.read(lastQuerySearchedProvider.notifier).state =
              //     lastQuery;
              showSearch(
                  context: context,
                  delegate: SearchMovieDelegate(
                    // searchMovieCallBack: movieRepository.seatchMovies,
                    widgetRef: ref,
                  ),
                  query: lastQuery);

              //   // delegate: //otra forma
              //   //     SearchMovieDelegate(searchMovieCallBack: (query) {
              //   //   return movieRepository.searchMovie(query);
              //   // }),
              // );
            },
            icon: const Icon(Icons.search_rounded))
      ],
    );
    //Este e sel viejo CustomAppBar que para usarlo se usa la propeidad flexibleSpace sel Sliver
    //   SafeArea(
    //       bottom: false,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //         child: Row(
    //           children: [
    //             Icon(
    //               Icons.movie_outlined,
    //               color: colors.primary,
    //             ),
    //             const SizedBox(width: 10),
    //             Text(
    //               "Cinemapedia",
    //               style: textStyle.titleLarge,
    //             ),
    //             const Spacer(),
    //             IconButton(
    //                 onPressed: () {}, icon: const Icon(Icons.search_rounded))
    //           ],
    //         ),
    //       ));
  }
}

typedef SearchMovieCallBack = Future<void> Function(String query);

class SearchMovieDelegate extends SearchDelegate {
  // final SearchMovieCallBack searchMovieCallBack;
  final WidgetRef widgetRef;

  SearchMovieDelegate(
      {
      // required this.searchMovieCallBack,
      required this.widgetRef});

  @override
  String get searchFieldLabel {
    return "Buscar pelicula";
  }

  @override //Posicion derecha del appbar
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query != "")
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override //Posicion izquierda del appbar
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // close(context, null); //en el null podemos re
        context.pop();
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override //Se muestra cuando se hace Enter
  Widget buildResults(BuildContext context) {
    return const Text("Placeholder texto de prueba");
  }

  //Cuando se llama el ShowSearch, y cada vez que escribo, se muestra como suegrencias
  @override
  Widget buildSuggestions(BuildContext context) {
    CustomAppbar.lastQuery = query;

    if (query.trim() == "") {
      return const Center(child: Text("Sin resultados"));
    }

    Future<List<Movie>> movieRepository =
        widgetRef.read(movieRepositoryProvider).searchMovie(query);

    return FutureBuilder(
        // future: searchMovieCallBack(query),
        // initialData: const [], //Data inicial
        future: movieRepository,
        builder: (context, snapshot) {
          final List<Movie> movies = snapshot.data ?? [];

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = movies[index];

              return ListTile(
                onTap: () {
                  context.push("/movieDetailsScreen/${movie.id}");
                },
                contentPadding: const EdgeInsets.only(left: 20),
                leading: movie.posterPath != ""
                    ? Image.network(
                        movie.posterPath,
                        width: 43,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/no-image-poster.png",
                        width: 43,
                        fit: BoxFit.cover,
                      ),
                title: Text(
                  movie.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: (movie.overview.length > 80)
                    ? Text("${movie.overview.substring(0, 80)}...")
                    : Text(movie.overview),
              );
            },
          );
        });
  }
}
