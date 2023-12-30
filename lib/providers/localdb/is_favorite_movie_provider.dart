import 'package:flutter_riverpod/flutter_riverpod.dart';

//Autodispose es para cerrar la instancia cuando se sale de pantalla quien la usa, y asi traer  una nueva instancia
//haciendo que el provider vuelva a su estado inicial
final isFavoriteMovieProvider =
    StateProvider.autoDispose<bool>((ref) => false);
