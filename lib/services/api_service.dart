import 'package:dio/dio.dart';
import '../models/character_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://swapi.dev/api/";

  Future<List<CharacterModel>> fetchCharacters(int page) async {
    try {
      final response = await _dio.get("$_baseUrl/people/?page=$page");

      if (response.statusCode == 200) {
        List<dynamic> results = response.data["results"];
        return results.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load characters");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<String>> fetchFilms(List<String> filmUrls) async {
    List<String> filmNames = [];
    try {
      for (String url in filmUrls) {
        final response = await _dio.get(url);
        if (response.statusCode == 200) {
          filmNames.add(response.data["title"]);
        }
      }
      return filmNames;
    } catch (e) {
      throw Exception("Error fetching films: $e");
    }
  }

  Future<String> fetchHomeworld(String homeworldUrl) async {
    try {
      final response = await _dio.get(homeworldUrl);
      if (response.statusCode == 200) {
        return response.data["name"];
      } else {
        throw Exception("Failed to load homeworld");
      }
    } catch (e) {
      throw Exception("Error fetching homeworld: $e");
    }
  }

  Future<List<CharacterModel>> searchCharacters(String query) async {
    try {
      final response = await Dio().get("https://swapi.dev/api/people/?search=$query");

      if (response.statusCode == 200) {
        List<dynamic> results = response.data["results"];
        return results.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to search characters");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }



}
