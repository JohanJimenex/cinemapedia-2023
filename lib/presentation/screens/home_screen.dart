import 'package:cinemapedia/presentation/views/favorites_movies_view.dart';
import 'package:cinemapedia/presentation/views/home_view.dart';
import 'package:cinemapedia/providers/page_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cinemapedia/config/constant/enviroment_const.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Asi se usa las variables de entorno, recuerda instalar el paquete
// body: Center(child: Text(Enviroment.theMovieDBAPIKey)),
// se cambio por una clase y constante para usar el .nombrePropiedad
// body: Center(child: Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY")),// ,

class HomeScreen extends ConsumerWidget {
  static String nameOfScreen = "HomeScreen";
  // final Widget view; //HomeView, FavoritesView, etc. desde GoRouter, esto se usa solo si usamos  ShellRouter de GotRouter,

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int indexOfView = ref.watch(pageIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: indexOfView,
        children: const [
          HomeView(),
          HomeView(),
          FavoriteMoviesView(),
        ],
      ),
      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
