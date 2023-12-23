// import 'dart:math';

import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_slidershow.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/providers/movies/movies_swiper_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/barril_providers.dart';
// import 'package:cinemapedia/config/constant/enviroment_const.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

//Convertimos un StefulWidget a un ConsumeStefulWidget de Riverpod,
//as podemos usar la el metodo iniState() para inciializar cosas, ademas poder usar la variable "ref" sin tener que pasarlo por el build "WidgetRef ref" ,
// pudieramos usar la otra fomra de ConsumerWidget parta StalessWidget pero tendriamos que pasarle la referencia por el build(context, ref)
class HomeScreen extends ConsumerStatefulWidget {
  static String nameOfScreen = "HomeScreen";

  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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

    return Scaffold(
      // body: Center(child: Text(Enviroment.theMovieDBAPIKey)),
      //se cambio por una clase y constante para usar el .nombrePropiedad
      // body: Center(child: Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY")),// ,
      body: moviesOnCarteleraForSwiper.isEmpty
          // ? const Center(child: CircularProgressIndicator())
          ? const FullScreenLoader()
          : CustomScrollView(slivers: [
              const CustomAppbar(),
              SliverList(
                  // delegate: SliverChildBuilderDelegate((context, index) {  return
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
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
              ])

                  // }, childCount: 1)

                  )
            ]),

      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
