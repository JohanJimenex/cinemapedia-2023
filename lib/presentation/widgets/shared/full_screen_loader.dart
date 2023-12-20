import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    List<String> messages = [
      "Preparando palomitas",
      "Cargando peliculas en cartelera",
      "Buscando las más populares",
    ];

    return Stream.periodic(const Duration(seconds: 2), (index) {
      return messages[index];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          StreamBuilder(
            stream: getLoadingMessage(),
            // initialData: initialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text(
                  "Cargando peliculas",
                  style: textTheme.titleLarge,
                );
              }
              return Text(
                snapshot.data!,
                style: textTheme.titleLarge,
              );
            },
          ),
        ],
      ),
    );
  }
}
