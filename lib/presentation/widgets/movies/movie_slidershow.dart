import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MovieSlidershow extends StatelessWidget {
  final List<Movie> moviesToShow;

  const MovieSlidershow({super.key, required this.moviesToShow});

  @override
  Widget build(BuildContext context) {
    final colorsOfTheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      // width: double.infinity,
      child: Swiper(
        itemCount: moviesToShow.length,
        scale: 0.8,
        viewportFraction: 0.8,
        autoplay: true,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colorsOfTheme.primary,
                color: Colors.black12)),
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = moviesToShow[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: DecoratedBox(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeIn(
                    //Animacion de animate_do
                    child: Image.network(
                      movie.backdropPath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          //viene el porcentaje de carga, y != null significa que esta cargando aun
                          return Center(child: Text("Cargando"));
                        }
                        return child;
                      },
                    ),
                  )),
            ),
          );
        },
        // control: const SwiperControl(),
      ),
    );
  }
}
