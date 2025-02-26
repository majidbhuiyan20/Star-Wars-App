class CharacterModel {
  final String name;
  final String height;
  final String birthYear;
  final String gender;

  CharacterModel({
    required this.name,
    required this.height,
    required this.birthYear,
    required this.gender,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json["name"],
      height: json["height"],
      birthYear: json["birth_year"],
      gender: json["gender"],
    );
  }
}
