import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacters extends CharacterEvent {
  final int page;

  const FetchCharacters(this.page);

  @override
  List<Object> get props => [page];
}
