import 'package:cinemapedia/domain/datasources/localdb_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDBDatasourceImpl extends LocalDBDataSource {
  late Future<Isar> dbInstance;

  IsarDBDatasourceImpl() {
    dbInstance = _openDB();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: dir.path);
    }
    return Isar.getInstance()!;
    // return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieInFavorite(int movieId) async {
    final Isar isar = await dbInstance;
    final Movie? resp =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return resp != null ? true : false;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final Isar isar = await dbInstance;
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie == null) {
      // await isar.movies.put(movie);

      // isar.writeTxn(() => isar.movies.put(movie));
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    } else {
      // await isar.movies.delete(favoriteMovie.id);
      // isar.writeTxn(() => isar.movies.delete(favoriteMovie.isarId!)); otra forma asyncrona
      isar.writeTxnSync(
          () => isar.movies.deleteSync(favoriteMovie.isarId!));
    }
  }

  @override //offeset es a partir de que cantidad, o sea, queiro 10 a partir del 5to por ejemplo
  Future<List<Movie>> loadMovies({int limit = 20, offset = 0}) async {
    final Isar isar = await dbInstance;
    final List<Movie> movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }
}
