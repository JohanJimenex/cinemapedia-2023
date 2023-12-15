// import 'dart:math';

import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_slidershow.dart';
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
    final moviesOnCartelera = ref.watch(nowPlayingMoviesProvider);

    return Scaffold(
      // body: Center(child: Text(Enviroment.theMovieDBAPIKey)),
      //se cambio por una clase y constante para usar el .nombrePropiedad
      // body: Center(child: Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY")),// ,
      body: moviesOnCartelera.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const CustomAppbar(),
                MovieSlidershow(moviesToShow: moviesOnCartelera)
              ],
            ),
    );
  }
}
