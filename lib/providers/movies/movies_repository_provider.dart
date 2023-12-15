import 'package:cinemapedia/infrastructure/datasources/themoviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Como la data que manejará este provider no cambiará, podemos crear un provider de solo lectura para consultar. Provider() // hay mas
// Proveedor del repositorio, si mañana cambia el datasource, solo es cambiarlo aqui,
//Ejemplo: final movieRepositoryProvider = Provider((ref) => MovieRepositoryImpl(NetflixDataSourceImpl()));
final movieRepositoryProvider =
    Provider((ref) => MovieRepositoryImpl(TheMovieDBDataSourceImpl()));
