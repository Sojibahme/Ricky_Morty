import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/data/models/character_model.dart';
import 'package:ricky_morty/domain/repositories/character_repository.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  int currentPage = 1;

  CharacterBloc(this.characterRepository) : super(CharacterInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
  }

  void _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    final currentState = state;
    try {
      if (currentState is CharacterInitial ||
          currentState is CharacterLoaded && !currentState.hasReachedMax) {
        if (currentState is CharacterInitial) {
          final characters =
              await characterRepository.fetchCharacters(currentPage);
          emit(CharacterLoaded(characters: characters, hasReachedMax: false));
        } else if (currentState is CharacterLoaded) {
          final characters =
              await characterRepository.fetchCharacters(currentPage);
          emit(characters.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CharacterLoaded(
                  characters: currentState.characters + characters,
                  hasReachedMax: false,
                ));
        }
        currentPage++;
      }
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }
}
