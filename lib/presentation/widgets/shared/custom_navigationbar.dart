// import 'package:go_router/go_router.dart';
// import 'package:cinemapedia/presentation/screens/barril_screens.dart';
import 'package:cinemapedia/providers/page_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavigationbar extends ConsumerWidget {
  const CustomNavigationbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(pageIndexProvider);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        ref.read(pageIndexProvider.notifier).state = index;
        // currentIndex = index;
        // setState(() {});
        // switch (index) {
        //   case 0:
        //     // context.go("/");
        //     break;
        //   case 1:
        //     // context.go("/category");
        //     break;
        //   case 2:
        //     // context.go("/favorites");
        //     break;
        //   default:
        // }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outlined), label: "Categorías"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded), label: "Favoritos"),
      ],
    );
  }
}
