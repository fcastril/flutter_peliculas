import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '4445015c53332456116862bfbd4d02a1';
  final String _lenguage = 'es-ES';

  List<Movie> onDisplay = [];

  MoviesProvider() {
    getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    var url = Uri.https(_urlBase, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _lenguage, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplay = nowPlayingResponse.results;
    notifyListeners();
  }
}