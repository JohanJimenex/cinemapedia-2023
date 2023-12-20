import 'package:flutter/material.dart';

class TitleForSlider extends StatelessWidget {
  final String title;
  final String badgeTitle;

  const TitleForSlider(
      {super.key, required this.title, required this.badgeTitle});

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.headlineSmall,
          ),
          const Spacer(),
          FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    colorsTheme.primary), // Cambia el color del ícono aquí
              ),
              child: Text(badgeTitle)),
        ],
      ),
    );
  }
}
