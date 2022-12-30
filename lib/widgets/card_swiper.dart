import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.length == 0) {
      return Container(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(child: CircularProgressIndicator.adaptive()));
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.60,
          itemHeight: size.height * 0.40,
          itemBuilder: (_, index) {
            final movie = movies[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: 'movie-instance'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPathImg),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
