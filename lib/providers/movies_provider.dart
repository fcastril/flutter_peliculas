import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '4445015c53332456116862bfbd4d02a1';
  final String _lenguage = 'es-ES';

  List<Movie> onDisplay = [];
  List<Movie> populars = [];
  List<Movie> upComing = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _upComingPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getUpComingMovies();
  }
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final body = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = MoviesDatesResponse.fromJson(body);

    onDisplay = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final body = await _getJsonData('/3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(body);

    populars = [...populars, ...popularResponse.results];
    notifyListeners();
  }

  getUpComingMovies() async {
    _upComingPage++;
    final body = await _getJsonData('/3/movie/upcoming', _upComingPage);

    final upComingResponse = MoviesDatesResponse.fromJson(body);

    upComing = [...upComing, ...upComingResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int id) async {
    final body = await _getJsonData('/3/movie/$id/credits');
    final creditsResponse = CreditsResponse.fromJson(body);

    moviesCast[id] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
