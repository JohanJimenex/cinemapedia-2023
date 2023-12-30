import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/views/barril_views.dart';
import 'package:cinemapedia/presentation/screens/test_screen.dart';
import 'package:cinemapedia/presentation/screens/barril_screens.dart';

//Ruta inicia "/" HomeView
final appRouter = GoRouter(initialLocation: "/", routes: [
  //Con este shellRoute podemos usar el bottonNav igationBar sin que se quite al ingresar a una nueva pantalla
  //Tambien sigue funcionando si las rutas estan fuera del shell router, ej: TestScreen

  // ShellRoute(
  //     //En el child viene la ruta que se ha llamado, ejemplo "/" viene HomeView, "/movieDetailScren" viene MovieDetailsScreen, etc
  //     builder: (context, state, child) {
  //       return HomeScreen(view: child);
  //     },
  //     routes: [
  //       GoRoute(
  //           path: "/",
  //           builder: (context, state) => const HomeView(),
  //           routes: [
  //             GoRoute(
  //                 //Recuerda que si vas  ausarlo en la web, y queires que sea como una ruta hija con Ejemplo: home/etc. puedes meterla dentro y quitar el slash /
  //                 path: "movieDetailsScreen/:id",
  //                 name: MovieDetailsScreen.nameOfScreen,
  //                 builder: (context, state) {
  //                   String movieId = state.pathParameters["id"] ?? "";
  //                   return MovieDetailsScreen(movieId: movieId);
  //                 }),
  //           ]),
  //       GoRoute(
  //         path: "/favorites",
  //         builder: (context, state) => const FavoriteMoviesView(),
  //       ),
  //     ]),

  GoRoute(
      path: "/", //ruta
      name: HomeScreen
          .nameOfScreen, //nombre de la ruta para poder llamarla por nombre
      builder: (context, state) =>
          const HomeScreen(), //Componente a cargar
      //Con esta configuracion de rutas hijas es para que en la web si actualiza la pagina siga apareciendo el boton de "Back",
      //Recuerda quitar el slash del path
      routes: [
        GoRoute(
            path: "movieDetailsScreen/:id",
            name: MovieDetailsScreen.nameOfScreen,
            builder: (context, state) {
              String movieId = state.pathParameters["id"] ?? "";
              return MovieDetailsScreen(movieId: movieId);
            }),
      ]),
  GoRoute(
    path: "/favorites",
    builder: (context, state) => const FavoriteMoviesView(),
  ),

  // GoRoute(
  //     path: "/movieDetailsScreen/:id", //ruta
  //     name: MovieDetailsScreen.nameOfScreen,
  //     builder: (context, state) {
  //       String movieId = state.pathParameters["id"] ?? "";
  //       //Esta valicacion la haremos en la pantalla movieDetalScree()
  //       // if (movieId == "") {
  //       //   return const HomeScreen();
  //       // }
  //       // final Movie movie = state.extra as Movie; capturar objeto enviaod por 'extra'
  //       // return MovieDetailsScreen(movieId: movieId, movie: movie); //lo enviamos al constructor

  //       return MovieDetailsScreen(movieId: movieId);
  //     }),
  GoRoute(
      path: "/test",
      name: "test",
      builder: (context, state) {
        return const TestScreen();
      }),
]);
