import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';

// Convertimos un StefulWidget a un ConsumeStefulWidget de Riverpod,
// asi podemos usar el metodo iniState() para inciializar cosas, ademas poder usar la variable "ref" sin tener que pasarlo por el build "WidgetRef ref" ,
// pudieramos usar la otra fomra de ConsumerWidget parta StalessWidget pero tendriamos que pasarle la referencia por el build(context, ref)

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final moviesOnCarteleraForSwiper = ref.watch(moviesForSwiperProvider);
    final moviesOnCartelera = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    return moviesOnCarteleraForSwiper.isEmpty
        // ? const Center(child: CircularProgressIndicator())
        ? const FullScreenLoader()
        : CustomScrollView(slivers: [
            const CustomAppbar(),
            SliverList(
              // delegate: SliverChildBuilderDelegate((context, index) {  return //forma d efernando herrera
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    //Lleva a la pantalla de pruebas
                    // TextButton(
                    //   onPressed: () {
                    //     context.push("/test");
                    //   },
                    //   // child: const SizedBox(),
                    //   child: const Text("."),
                    // ),
                    MovieSlidershow(
                        moviesToShow: moviesOnCarteleraForSwiper),
                    const Divider(
                      height: 20,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const TitleForSlider(
                        title: "Peliculas en cartelera",
                        badgeTitle: "Hoy"),
                    MovieHorizontalListView(
                      movies: moviesOnCartelera,
                      loadMoreMovies: () {
                        //Cargar mas peliculas
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage();
                      },
                    ),
                    const TitleForSlider(
                        title: "Populares", badgeTitle: "Este mes"),
                    MovieHorizontalListView(
                      movies: popularMovies,
                      loadMoreMovies: () {
                        //Cargar mas peliculas
                        ref
                            .read(popularMoviesProvider.notifier)
                            .loadNextPage();
                      },
                    ),
                    const TitleForSlider(
                        title: "Mejor calificadas",
                        badgeTitle: "Este mes"),
                    MovieHorizontalListView(
                      movies: topRatedMovies,
                      loadMoreMovies: () {
                        ref
                            .read(topRatedMoviesProvider.notifier)
                            .loadNextPage();
                      },
                    ),
                    const TitleForSlider(
                        title: "Pronto en cines", badgeTitle: "Este mes"),
                    MovieHorizontalListView(
                      movies: upComingMovies,
                      loadMoreMovies: () {
                        ref
                            .read(upComingMoviesProvider.notifier)
                            .loadNextPage();
                      },
                    ),
                  ],
                )
              ]),
            )
          ]);
  }
}
