class CharacterModel {
  final String name;
  final String height;
  final String mass;
  final String birthYear;
  final String gender;
  final List<String> films; // List of film URLs
  final String homeworld; // URL to the homeworld API

  CharacterModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.birthYear,
    required this.gender,
    required this.films,
    required this.homeworld,
  });

  // Add fromJson constructor for API parsing
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      films: List<String>.from(json['films']),
      homeworld: json['homeworld'],
    );
  }
}
