import 'package:ricky_morty/data/models/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> fetchCharacters(int page);
}
