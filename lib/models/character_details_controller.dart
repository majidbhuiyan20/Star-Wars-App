import 'package:get/get.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterDetailsController extends GetxController {
  final ApiService _apiService = ApiService();

  var films = <String>[].obs;
  var homeworld = "".obs;
  var isLoading = true.obs;

  void fetchAdditionalDetails(CharacterModel character) async {
    try {
      isLoading(true);

      List<String> filmNames = await _apiService.fetchFilms(character.films);
      String homeworldName = await _apiService.fetchHomeworld(character.homeworld);

      films.assignAll(filmNames);
      homeworld.value = homeworldName;
    } catch (e) {
      print("Error fetching details: $e");
    } finally {
      isLoading(false);
    }
  }
}
