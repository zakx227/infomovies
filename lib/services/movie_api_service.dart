import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infomovis/models/cast.dart';
import 'package:infomovis/models/movie.dart';
import 'package:infomovis/models/video.dart';
import 'package:infomovis/utils/constants.dart';

class MovieApiService {
  final String _url = "https://api.themoviedb.org/3";
  final String _endpointPopular = "/movie/popular";
  final String _endpointSearch = "/search/movie";

  Future<List<Movie>> fetchMovies() async {
    final Uri uri = Uri.parse("$_url$_endpointPopular?api_key=$apiKey");
    var reponse = await http.get(uri);
    return result(reponse);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final Uri uri = Uri.parse(
      "$_url$_endpointSearch?api_key=$apiKey&query=$query",
    );
    final reponse = await http.get(uri);
    return result(reponse);
  }

  Future<List<Movie>> result(http.Response reponse) async {
    if (reponse.statusCode == 200) {
      List<dynamic> data = json.decode(reponse.body)['results'];
      return data.map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception('Erreur : ${reponse.reasonPhrase}');
    }
  }

  Future<Movie> fetchMovieDetail(int id) async {
    final uri = Uri.parse('$_url/movie/$id?api_key=$apiKey&language=fr-FR');

    final reponse = await http.get(uri);

    if (reponse.statusCode == 200) {
      final data = jsonDecode(reponse.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Erreur : ${reponse.reasonPhrase}');
    }
  }

  Future<List<Cast>> fetchMovieCast(int id) async {
    final uri = Uri.parse('$_url/movie/$id/credits?api_key=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['cast'];
      return data.map((m) => Cast.fromJson(m)).toList();
    } else {
      throw Exception('Erreur lors du chargement du cast');
    }
  }

  Future<List<Video>> fetchMovieVideos(int movieId) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=fr-FR',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> videosJson = jsonData['results'];
      return videosJson.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des vidéos');
    }
  }
}
