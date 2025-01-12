class CharacterModel {
  final String id;
  final String name;
  final String image;

  CharacterModel({required this.id, required this.name, required this.image});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
