import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchMovieDelegate(),
                  query: "");
            },
            icon: const Icon(Icons.search_rounded))
      ],
    );
    //Este e sel viejo CustomAppBar que para usarlo se usa la propeidad flexibleSpace sel Sliver
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

class SearchMovieDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel {
    return "Buscar pelicula";
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query != "")
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // close(context, null); //en el null podemos re
        context.pop();
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("Resultado ");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Sin resultados"));
  }
}
