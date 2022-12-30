import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '4445015c53332456116862bfbd4d02a1';
  final String _lenguage = 'es-ES';

  List<Movie> onDisplay = [];
  List<Movie> populars = [];
  int popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final body = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(body);

    onDisplay = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    popularPage++;
    final body = await _getJsonData('/3/movie/popular', popularPage);

    final popularResponse = PopularResponse.fromJson(body);

    populars = [...populars, ...popularResponse.results];
    notifyListeners();
  }
}
