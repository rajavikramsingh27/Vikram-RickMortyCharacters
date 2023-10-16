

// import 'package:qurhealth_task/Models/Character.dart';

part of 'rick_morty_characters_cubit.dart';

// @immutable
abstract class RickMortyCharactersState {}

class RickMortyCharactersInitial extends RickMortyCharactersState {}

class LoadingState extends RickMortyCharactersState {
  @override
  List<Object> get props => [];
}

class LoadedState extends RickMortyCharactersState {
  LoadedState({
    this.arrProductList = const [],
  });

  final List<Character>? arrProductList;

  @override
  List<Object> get props => [arrProductList!];

}

class ErrorState extends RickMortyCharactersState {
  @override
  List<Object> get props => [];
}
