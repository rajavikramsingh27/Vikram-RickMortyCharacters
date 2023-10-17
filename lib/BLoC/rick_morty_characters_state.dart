

// import 'package:qurhealth_task/Models/Character.dart';

part of 'rick_morty_characters_cubit.dart';

// @immutable
abstract class RickMortyCharactersState extends Equatable {
  @override
  List<Object> get props => [];
}

class RickMortyCharactersInitial extends RickMortyCharactersState {}

class RickMortyCharactersLoadingState extends RickMortyCharactersState {
  @override
  List<Object> get props => [];
}

class RickMortyCharactersLoadedState extends RickMortyCharactersState {
  RickMortyCharactersLoadedState({
    this.arrCharacterList = const [],
  });

  final List<Character>? arrCharacterList;

  @override
  List<Object> get props => [arrCharacterList!];

}

class RickMortyCharactersErrorState extends RickMortyCharactersState {
  @override
  List<Object> get props => [];
}

