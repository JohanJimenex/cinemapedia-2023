import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationbar extends StatefulWidget {
  const CustomNavigationbar({super.key});

  @override
  State<CustomNavigationbar> createState() => _CustomNavigationbarState();
}

class _CustomNavigationbarState extends State<CustomNavigationbar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        currentIndex = index;
        setState(() {});
        switch (index) {
          case 0:
            context.go("/");

            break;
          case 1:
            context.go("/category");
            break;
          case 2:
            context.go("/favorites");
            break;
          default:
        }
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
