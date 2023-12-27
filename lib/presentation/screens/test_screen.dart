import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/test_provider.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends ConsumerState<TestScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(conPeajeProvider.notifier).miMetodoX();
  }

  @override
  Widget build(BuildContext context) {
    final String saludo = ref.read(stringProviderUnaSoloLectura);
    int numero = ref.watch(intProviderCambiarEstadoYEstarPendiente);
    List<int> listNumeros = ref.watch(listNumerosProvider);
    final claseX = ref.read(claseXProvider);
    ClaseZ claseZ = ref.watch(claseZProvider);
    // final klk = ref.watch(klkPRovider);una copia de listNumerosProvider
    final peliculasEnCartelera =
        ref.read(peticionHttpAPIProvider).getNowPlaying();
    final elPeaje = ref.watch(conPeajeProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: peliculasEnCartelera,
                initialData: const [],
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Text(snapshot.data[0].title);
                },
              ),
              Text(saludo),
              Text(numero.toString()),
              Text(elPeaje["a"] ?? ""),
              SizedBox(
                height: 200,
                width: 0,
                child: ListView.builder(
                  itemCount: listNumeros.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      listNumeros[index].toString(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 200,
                width: 100,
                child: ListView.builder(
                  itemCount: claseZ.listString.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      claseZ.listString[index],
                    );
                  },
                ),
              ),
              Text(claseX.metodoSaludar()),
              Text(claseX.nombre),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref
                  .read(intProviderCambiarEstadoYEstarPendiente.notifier)
                  .state++;
              ref.read(listNumerosProvider.notifier).state.add(6);
              // ref.read(klkPRovider.notifier).state.add(6); una copia de listnumeroprovider

              ref
                  .read(claseZProvider.notifier)
                  .state
                  .listString
                  .add("pam");
            },
            child: const Icon(Icons.add_circle_outline_rounded),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.yard_outlined)),
        ],
      ),
    );
  }
}
