import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = 'TU_API_KEY_DE_TMDB';

  Future<List<dynamic>> fetchPopularMovies() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-MX',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Error al cargar las películas');
    }
  }
}
