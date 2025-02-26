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
    // Getting screen width using MediaQuery for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: CustomColor.appBarColor,
              ),

              child: Text(
                'Star Wars App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: CustomColor.iconColor),
              title: Text('Home', style: TextStyle(color: CustomColor.textColor)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: CustomColor.iconColor),
              title: Text('About', style: TextStyle(color: CustomColor.textColor)),
              onTap: () {
                Navigator.pop(context);
               // Get.to(() => AboutPage());
              },
            ), ListTile(
              leading: Icon(Icons.settings, color: CustomColor.iconColor),
              title: Text('Settings', style: TextStyle(color: CustomColor.textColor)),
              onTap: () => { Navigator.pop(context), //Get.to(() => SettingsPage())
               },
            ),
          ],
        ),
      ),
      backgroundColor: CustomColor.backgroundColor, // Set background color

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColor.appBarColor,
        title: Text(
          "Star Wars Characters",
          style: TextStyle(
            color: CustomColor.appBarTextColor,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth > 600 ? 24 : 22,  // Adjust title font size based on screen width
          ),
        ),
        centerTitle: true, // Make sure to keep centerTitle: true,
        elevation: 5,
      ),


      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(screenWidth > 600 ? 16.0 : 12.0), // Adjust padding based on screen width
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 20 : 10, vertical: 5),
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
                            padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 30 : 20, vertical: 12),
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
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 20 : 18, // Adjust title font size based on screen width
                          fontWeight: FontWeight.bold,
                          color: CustomColor.textColor,
                        ),
                      ),
                      subtitle: Text(
                        "Height: ${character.height} | Gender: ${character.gender}",
                        style: TextStyle(fontSize: screenWidth > 600 ? 16 : 14, color: Colors.grey[700]),
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
