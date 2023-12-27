import 'package:flutter/material.dart';

class FavoriteMoviesView extends StatelessWidget {
  const FavoriteMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Favories Movies "),
      ),
    );
  }
}
