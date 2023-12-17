// import 'dart:math';

import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_slidershow.dart';
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
  final String nameOfScreen = "HomeScreen";

  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final moviesOnCarteleraForSwiper = ref.watch(moviesForSwiperProvider);
    final moviesOnCartelera = ref.watch(nowPlayingMoviesProvider);
    final colorsTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // body: Center(child: Text(Enviroment.theMovieDBAPIKey)),
      //se cambio por una clase y constante para usar el .nombrePropiedad
      // body: Center(child: Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY")),// ,
      body: moviesOnCarteleraForSwiper.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const CustomAppbar(),
                  MovieSlidershow(
                      moviesToShow: moviesOnCarteleraForSwiper),
                  const Divider(
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Peliculas en cartelera",
                          style: textTheme.headlineSmall,
                        ),
                        const Spacer(),
                        FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  colorsTheme
                                      .primary), // Cambia el color del ícono aquí
                            ),
                            child: const Text('Lunes 1')),
                      ],
                    ),
                  ),
                  MovieHorizontalListView(
                    movies: moviesOnCartelera,
                    loadMoreMovies: () {
                      //Cargar mas peliculas
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                ],
              ),
            ),

      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
