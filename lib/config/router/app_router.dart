import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/barril_screens.dart';

final appRouter = GoRouter(initialLocation: "/homeScreen", routes: [
  GoRoute(
    path: "/homeScreen", //ruta
    name: HomeScreen
        .nameOfScreen, //nombre de la ruta para poder llamarla por nombre
    builder: (context, state) => const HomeScreen(), //Componente a cargar
    //Con esta configuracion de rutas hijas es para que en la web si actualiza la pagina siga apareciendo el boton de "Back",
    //Recuerda quitar el slash del path
    // routes: [
    //   GoRoute(
    //       path: "movieDetailsScreen/:id",
    //       name: MovieDetailsScreen.nameOfScreen,
    //       builder: (context, state) {
    //         String movieId = state.pathParameters["id"] ?? "";
    //         return MovieDetailsScreen(movieId: movieId);
    //       }),
    // ]
  ),
  GoRoute(
      path: "/movieDetailsScreen/:id", //ruta
      name: MovieDetailsScreen.nameOfScreen,
      builder: (context, state) {
        String movieId = state.pathParameters["id"] ?? "";
        //Esta valicacion la haremos en la pantalla movieDetalScree()
        // if (movieId == "") {
        //   return const HomeScreen();
        // }
        // final Movie movie = state.extra as Movie; capturar objeto enviaod por 'extra'
        // return MovieDetailsScreen(movieId: movieId, movie: movie); //lo enviamos al constructor

        return MovieDetailsScreen(movieId: movieId);
      }),
]);
