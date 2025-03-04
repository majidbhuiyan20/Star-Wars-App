import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/app_colors.dart';
import '../models/character_details_controller.dart';
import '../models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  final CharacterDetailsController controller = Get.put(CharacterDetailsController());

  CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchAdditionalDetails(character);

    // MediaQuery to get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.appBarColor,
        elevation: 4.0,
        title: Text(
          character.name,
          style: TextStyle(
            color: CustomColor.appBarTextColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth > 600 ? 26 : 22, // Adjust font size for larger screens
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth > 600 ? 24.0 : 16.0), // Adjust padding for larger screens
        child: Column(
          children: [
            // Character Info Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: CustomColor.cardColor,
              child: Padding(
                padding: EdgeInsets.all(screenWidth > 600 ? 24.0 : 16.0), // Adjust padding based on screen size
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Character Information",
                        style: TextStyle(
                            fontSize: screenWidth > 600 ? 24 : 20, // Larger font size for larger screens
                            fontWeight: FontWeight.bold,
                            color: CustomColor.textColor)),
                    Divider(color: Colors.grey),
                    _infoRow("Name", character.name),
                    _infoRow("Height", "${character.height} cm"),
                    _infoRow("Mass", "${character.mass} kg"),
                    _infoRow("Birth Year", character.birthYear),
                    _infoRow("Gender", character.gender),
                    // Using GetX for Homeworld
                    Obx(() => _infoRow("Homeworld", controller.homeworld.isNotEmpty ? controller.homeworld.value : "Loading...")),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenWidth > 600 ? 30 : 20), // Adjust spacing based on screen size

            // Films Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: CustomColor.cardColor,
              child: Padding(
                padding: EdgeInsets.all(screenWidth > 600 ? 24.0 : 16.0), // Adjust padding based on screen size
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Films",
                        style: TextStyle(
                            fontSize: screenWidth > 600 ? 24 : 20, // Larger font size for larger screens
                            fontWeight: FontWeight.bold,
                            color: CustomColor.textColor)),
                    Divider(color: Colors.grey),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return controller.films.isNotEmpty
                          ? Column(children: controller.films.map((film) => _filmTile(film)).toList())
                          : Text("No films available", style: TextStyle(color: Colors.red));
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for displaying info rows
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[700])),
          Text(value, style: TextStyle(fontSize: 16, color: CustomColor.textColor)),
        ],
      ),
    );
  }

  // Helper widget for displaying films
  Widget _filmTile(String film) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.movie, color: CustomColor.iconColor, size: 18),
          SizedBox(width: 8),
          Text(film, style: TextStyle(fontSize: 16, color: CustomColor.textColor)),
        ],
      ),
    );
  }
}
