import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class TabChanged extends NavigationState {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class CastDetailsView extends NavigationState {
  final String characterId;

  const CastDetailsView(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class TabSelected extends NavigationEvent {
  final int index;

  const TabSelected(this.index);

  @override
  List<Object?> get props => [index];
}

class ShowCastDetails extends NavigationEvent {
  final String characterId;

  const ShowCastDetails(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

class GoToCastTab extends NavigationEvent {
  const GoToCastTab();

  @override
  List<Object?> get props => [];
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const TabChanged(0)) {
    on<TabSelected>((event, emit) {
      emit(TabChanged(event.index));
    });
    on<ShowCastDetails>((event, emit) {
      emit(CastDetailsView(event.characterId));
    });
    on<GoToCastTab>((event, emit) {
      emit(const CastDetailsView(''));
    });
  }
}
