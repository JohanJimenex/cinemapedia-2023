import 'package:flutter/material.dart';

class CustomNavigationbar extends StatelessWidget {
  const CustomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
