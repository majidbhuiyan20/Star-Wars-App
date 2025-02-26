import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_wars/core/app_colors.dart';
import '../view_models/character_view_model.dart';
import 'character_details_page.dart';

class HomePage extends StatelessWidget {
  final CharacterViewModel viewModel = Get.put(CharacterViewModel());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor, // Set background color

      appBar: AppBar(
        backgroundColor: CustomColor.appBarColor,
        title: Text(
          "Star Wars Characters",
          style: TextStyle(
            color: CustomColor.appBarTextColor,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => viewModel.searchCharacters(value),
              decoration: InputDecoration(
                hintText: "Search character...",
                prefixIcon: Icon(Icons.search, color: CustomColor.iconColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemBuilder: (context, index) {
                  if (index == viewModel.filteredCharacters.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: viewModel.loadMore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: Text("Load More", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    );
                  }
                  final character = viewModel.filteredCharacters[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: CustomColor.cardColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundColor: CustomColor.iconColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        character.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CustomColor.textColor),
                      ),
                      subtitle: Text(
                        "Height: ${character.height} | Gender: ${character.gender}",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: CustomColor.iconColor),
                      onTap: () => Get.to(() => CharacterDetailsScreen(character: character)),
                    ),
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
