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
}
