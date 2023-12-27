import 'package:cinemapedia/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este Provider() es para una sola lectura, no se necesita estar pendiente ya que no cambia
final stringProviderUnaSoloLectura = Provider<String>((ref) {
  return "Hello";
});

//Este StateProvider() es para poder hacer cambio y hay que estar pendiente con .watch
final intProviderCambiarEstadoYEstarPendiente = StateProvider<int>((ref) {
  return 0;
});

//Otro StateProvider
final listNumerosProvider = StateProvider<List<int>>((ref) {
  return [0, 1, 2, 3, 4, 5];
});

//Otro Provider de solo lectura
final claseXProvider = Provider<ClaseX>((ref) {
  return ClaseX();
});

class ClaseX {
  String nombre = "johan";
  metodoSaludar() {
    return "klk Mundo";
  }
}

//Otro StateProvider para poder cambiar sus valores
final claseZProvider = StateProvider<ClaseZ>((ref) {
  return ClaseZ();
});

class ClaseZ {
  List<String> listString = ["Manuel"];
}

//Simpleemnte una copia  de listNumerosProvider, y se puede manipular
final klkPRovider = StateProvider<List<int>>((ref) {
  final otroProviderX = ref.watch(listNumerosProvider);
  return otroProviderX;
});

//Otro StateProvider
final peticionHttpAPIProvider = StateProvider((ref) {
  final repositoryProvider = ref.watch(movieRepositoryProvider);
  return repositoryProvider;
});

//Este provider nos permite usar un peaje para poder hacer cualqueir cosa antes de accionar
final conPeajeProvider =
    StateNotifierProvider<PeajeNotifier, Map<String, String>>((ref) {
  return PeajeNotifier();
});

class PeajeNotifier extends StateNotifier<Map<String, String>> {
  // int contador = 0;
  PeajeNotifier() : super({});
  Future<void> miMetodoX() async {
    // print(contador);
    // if (contador > 4) return;

    // contador++;
    // state = {...state, "A$contador": "klk"};
    await Future.delayed(const Duration(seconds: 1));
    state = {"a": "b"};
  }
}

class ClaseHija extends ClasePadre {
  //Primera forma
  ClaseHija(super.edad, super.nombre);
  //Segunda forma
  //ClaseHija() : super(0, '');
}

abstract class ClasePadre {
  int edad;
  String nombre;
  ClasePadre(this.edad, this.nombre);
}
