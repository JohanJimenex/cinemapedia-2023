import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return SliverAppBar(
      floating: true,
      // flexibleSpace: FlexibleSpaceBar(
      //   title: CustomAppbar(),
      // ),
      leading: Icon(Icons.movie_creation_outlined, color: colors.primary),
      title: Row(
        children: [
          Text(
            "Cinemapedia",
            style: textStyle.titleLarge,
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.search_rounded))
      ],
    );

    //Este e sel viejo CustomAppBar que par a usarlo se usa la propeidad flesiblespace sel Sliver
    //   SafeArea(
    //       bottom: false,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //         child: Row(
    //           children: [
    //             Icon(
    //               Icons.movie_outlined,
    //               color: colors.primary,
    //             ),
    //             const SizedBox(width: 10),
    //             Text(
    //               "Cinemapedia",
    //               style: textStyle.titleLarge,
    //             ),
    //             const Spacer(),
    //             IconButton(
    //                 onPressed: () {}, icon: const Icon(Icons.search_rounded))
    //           ],
    //         ),
    //       ));
  }
}
