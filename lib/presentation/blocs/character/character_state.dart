import 'package:equatable/equatable.dart';
import 'package:ricky_morty/data/models/character_model.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;
  final bool hasReachedMax;

  const CharacterLoaded(
      {required this.characters, required this.hasReachedMax});

  CharacterLoaded copyWith({
    List<CharacterModel>? characters,
    bool? hasReachedMax,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [characters, hasReachedMax];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
