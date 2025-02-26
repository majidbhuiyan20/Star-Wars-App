import 'package:get/get.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterViewModel extends GetxController {
  final ApiService _apiService = ApiService();
  var characters = <CharacterModel>[].obs;
  var filteredCharacters = <CharacterModel>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCharacters();
    super.onInit();
  }

  void fetchCharacters() async {
    try {
      isLoading.value = true;
      var newCharacters = await _apiService.fetchCharacters(page.value);
      characters.addAll(newCharacters);
      filteredCharacters.assignAll(characters); // Initialize filtered list
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    page.value++;
    fetchCharacters();
  }

  // Search characters across all available characters in the API
  void searchCharacters(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCharacters.assignAll(characters);
    } else {
      isLoading.value = true;
      try {
        // Reset the filtered characters list
        filteredCharacters.clear();

        // Fetch characters from API based on the query
        var searchResults = await _apiService.searchCharacters(query);

        // Update filtered list with search results
        filteredCharacters.assignAll(searchResults);
      } catch (e) {
        print("Search Error: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }
}