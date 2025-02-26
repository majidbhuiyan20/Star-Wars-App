import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  final ApiService _apiService = ApiService();
  List<String> _films = [];
  String _homeworld = "";

  @override
  void initState() {
    super.initState();
    _fetchAdditionalDetails();
  }

  Future<void> _fetchAdditionalDetails() async {
    try {
      // Fetch Films
      List<String> filmNames = await _apiService.fetchFilms(widget.character.films);

      // Fetch Homeworld
      String homeworldName = await _apiService.fetchHomeworld(widget.character.homeworld);

      setState(() {
        _films = filmNames;
        _homeworld = homeworldName;
      });
    } catch (e) {
      print("Error fetching details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.character.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.character.name}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Height: ${widget.character.height} cm"),
            Text("Mass: ${widget.character.mass} kg"),
            Text("Birth Year: ${widget.character.birthYear}"),
            Text("Gender: ${widget.character.gender}"),
            SizedBox(height: 10),
            _homeworld.isNotEmpty ? Text("Homeworld: $_homeworld") : CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Films:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _films.isNotEmpty
                ? Column(children: _films.map((film) => Text("- $film")).toList())
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
