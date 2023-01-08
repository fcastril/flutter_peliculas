import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas en Cine'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (() => showSearch(
                    context: context, delegate: MovieSearchDelegate())),
                icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplay),
              MovieSlider(
                movies: moviesProvider.populars,
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.upComing,
                title: 'Muy pronto',
                onNextPage: () => moviesProvider.getUpComingMovies(),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ));
  }
}
