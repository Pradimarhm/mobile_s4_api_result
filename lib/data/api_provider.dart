import 'dart:convert';
import 'package:http/http.dart';
import 'package:acarabkpm2/model/popular_movies.dart';

class ApiProvider {
  String apiKey = "50503a8531df88f71bc535690a2dde48";
  String baseUrl = "https://api.themoviedb.org/3";

  Client client = Client();

  Future<PopularMovies> getPopularMovies() async {
    Response response =
        await client.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      return PopularMovies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
