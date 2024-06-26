import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // instalar el paquete flutter_dotenv.dart y configurar en assets en el pupspec.yaml
  // para usarlo : dotenv.env['nombre_variable'] ?? "no existe variable"
  await dotenv.load(fileName: ".env");

  //Bloquear orientacion
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //La clase ProviderScope es para configurar el manejador de estado de RiverPod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Info Movie',
      theme: AppTheme().getTheme(),
    );
  }
}
