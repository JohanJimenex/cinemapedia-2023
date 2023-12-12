import 'package:cinemapedia/config/constant/enviroment_const.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  final String nameOfScreen = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              // Text(dotenv.env["THE_MOVIEDB_API_KEY"] ?? "No existe API KEY"), se cambio por una clase y constante para usar el .nombrePropiedad
              Text(Enviroment.theMovieDBAPIKey)),
    );
  }
}
