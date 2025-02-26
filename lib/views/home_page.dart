import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_models/character_view_model.dart';
import 'character_details_page.dart';

class HomePage extends StatelessWidget {
  final CharacterViewModel viewModel = Get.put(CharacterViewModel());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Star Wars Characters")),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => viewModel.searchCharacters(value),
              decoration: InputDecoration(
                hintText: "Search character...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          // Character List
          Expanded(
            child: Obx(() {
              if (viewModel.isLoading.value && viewModel.filteredCharacters.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: viewModel.filteredCharacters.length + 1,
                itemBuilder: (context, index) {
                  if (index == viewModel.filteredCharacters.length) {
                    return ElevatedButton(
                      onPressed: viewModel.loadMore,
                      child: Text("Load More"),
                    );
                  }
                  final character = viewModel.filteredCharacters[index];
                  return ListTile(
                    title: Text(character.name),
                    subtitle: Text("Height: ${character.height} | Gender: ${character.gender}"),
                    onTap: () => Get.to(() => CharacterDetailsScreen(character: character)),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
