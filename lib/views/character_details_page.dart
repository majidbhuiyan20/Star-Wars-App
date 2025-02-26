import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterModel character;

   CharacterDetailsPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${character.name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Height: ${character.height}"),
            Text("Birth Year: ${character.birthYear}"),
            Text("Gender: ${character.gender}"),
          ],
        ),
      ),
    );
  }
}
