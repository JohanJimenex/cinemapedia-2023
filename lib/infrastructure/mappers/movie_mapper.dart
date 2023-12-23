//El objetivo de este mapper/clase, es leer diferentes modelos y crear/mapearlos con nuestra entidad
//LA idea es crear un mapper para cada modelo diferente, si viene de moviedb, netflixdb u otro poder mapear cada uno con nuestra entidad
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details_repsonse.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBModelToEntity(MovieMovieDB movieDbModel) => Movie(
      adult: movieDbModel.adult,
      backdropPath: movieDbModel.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDbModel.backdropPath}"
          : "",
      //se espera una lista de String y viene una lista d eInt, iteramos para convertirlos a String y luego el Iterable a una Lista
      genreIds: movieDbModel.genreIds.map((e) => e.toString()).toList(),
      id: movieDbModel.id,
      originalLanguage: movieDbModel.originalLanguage,
      originalTitle: movieDbModel.originalTitle,
      overview: movieDbModel.overview,
      popularity: movieDbModel.popularity,
      posterPath: movieDbModel.posterPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDbModel.posterPath}"
          : "",
      releaseDate: movieDbModel.releaseDate,
      title: movieDbModel.title,
      video: movieDbModel.video,
      voteAverage: movieDbModel.voteAverage,
      voteCount: movieDbModel.voteCount);

  static Movie movieDBDetailsModelToEntity(
      MovieDetailsResponse movieDetails) {
    Movie movieDB = Movie(
        adult: movieDetails.adult,
        backdropPath: movieDetails.backdropPath != ""
            ? "https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}"
            : "",
        genreIds:
            movieDetails.genres.map((e) => e.name.toString()).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: movieDetails.posterPath != ""
            ? "https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}"
            : "",
        releaseDate: movieDetails.releaseDate,
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount);

    return movieDB;
  }

  //otro mapper par aNetfliz por ejemplo
  // static Movie movieNetflixModelToEntity(MovieNetflix movieNetflix) => Movie(
  // adult: movieNetflix.adult,
  // backdropPath: movieNetflix.backdropPath != ""
  //     ? "https://image.tmdb.org/t/p/w500/${movieNetflix.backdropPath}"
  //     : "assets/images/no-image.jpeg",
  // //se espera una lista de String y viene una lista d eInt, iteramos para convertirlos a String y luego el Iterable a una Lista
  // genreIds: movieNetflix.genreIds.map((e) => e.toString()).toList(),
  // id: movieNetflix.id,
  // originalLanguage: movieNetflix.originalLanguage,
  // originalTitle: movieNetflix.originalTitle,
  // overview: movieNetflix.overview,
  // popularity: movieNetflix.popularity,
  // posterPath: movieNetflix.posterPath != ""
  //     ? "https://image.tmdb.org/t/p/w500/${movieNetflix.posterPath}"
  //     : "assets/images/no-image-poster.png",
  // releaseDate: movieNetflix.releaseDate,
  // title: movieNetflix.title,
  // video: movieNetflix.video,
  // voteAverage: movieNetflix.voteAverage,
  // voteCount: movieNetflix.voteCount);
}
