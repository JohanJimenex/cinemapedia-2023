import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/providers/test_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends ConsumerState<TestScreen> {
  late final YoutubePlayerController controller;
  late final YoutubePlayerController controllerFernando;

  @override
  void initState() {
    super.initState();
    ref.read(conPeajeProvider.notifier).miMetodoX();
    controller = YoutubePlayerController(
      initialVideoId: '0kQ8i2FpRDk',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

    controllerFernando = YoutubePlayerController(
      initialVideoId: "0kQ8i2FpRDk",
      flags: const YoutubePlayerFlags(
        hideThumbnail: false,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String saludo = ref.read(stringProviderSoloLectura);
    int numero = ref.watch(intProviderCambiarEstadoYEstarPendiente);
    List<int> listNumeros = ref.watch(listNumerosProvider);
    final claseX = ref.read(claseXProvider);
    ClaseZ claseZ = ref.watch(claseZProvider);
    // final klk = ref.watch(klkPRovider);una copia de listNumerosProvider
    final peliculasEnCartelera =
        ref.read(peticionHttpAPIProvider).getNowPlaying();
    final elPeaje = ref.watch(conPeajeProvider);

    //Es igual al .watch pero nos permite rejugar mas
    ref.listen(intProviderCambiarEstadoYEstarPendiente,
        (actualValue, newValue) {});

// ==============YOUTUBE PLAYER===========================================================

    YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      // videoProgressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(backgroundColor: Colors.red),
      onReady: () {},
    );
// =====================================================================================
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YoutubePlayer(controller: controller),
              YoutubePlayer(controller: controllerFernando),
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
