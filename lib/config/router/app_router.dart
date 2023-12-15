import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/barril_screens.dart';

final appRouter = GoRouter(initialLocation: "/homeScreen", routes: [
  GoRoute(
    path: "/homeScreen", //ruta
    name: const HomeScreen()
        .nameOfScreen, //nombre de la ruta para poder llamarla por nombre
    builder: (context, state) => const HomeScreen(), //Componente a cargar
  ),
]);
