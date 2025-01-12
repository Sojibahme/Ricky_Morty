import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ricky_morty/data/graphql/graphql_service.dart';
import 'package:ricky_morty/domain/repositories/character_repository.dart';
import 'package:ricky_morty/data/models/character_model.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  final GraphQLService graphqlService;

  CharacterRepositoryImpl(this.graphqlService);

  @override
  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final result = await graphqlService.performQuery(
      '''
      query GetCharacters(\$page: Int!) {
        characters(page: \$page) {
          results {
            id
            name
            image
          }
        }
      }
      ''',
      variables: {'page': page},
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final characters = result.data!['characters']['results'] as List<dynamic>;
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}
