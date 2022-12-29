import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('Movies Provider inicializado ....');
    getOnDisplayMovies();
  }
  getOnDisplayMovies() {
    print('Get On Display  Movies');
  }
}
