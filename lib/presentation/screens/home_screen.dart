import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/barril_widgets.dart';
// import 'package:cinemapedia/config/constant/enviroment_const.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Asi se usa las variables de entorno, recuerda instalar el paquete
// body: Center(child: Text(Enviroment.theMovieDBAPIKey)),
// se cambio por una clase y constante para usar el .nombrePropiedad
// body: Center(child: Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY")),// ,

class HomeScreen extends StatelessWidget {
  static String nameOfScreen = "HomeScreen";
  final Widget view; //HomeView, FavoritesView, etc. desde GoRouter

  const HomeScreen({super.key, required this.view});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view,
      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
