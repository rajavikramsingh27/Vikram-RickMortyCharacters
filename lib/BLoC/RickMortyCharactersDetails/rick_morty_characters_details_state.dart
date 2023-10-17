part of 'rick_morty_characters_details_cubit.dart';


@immutable
abstract class RickMortyCharactersDetailsState extends Equatable {}

class RickMortyCharactersDetailsInitial extends RickMortyCharactersDetailsState {
  @override
  List<Object> get props => [];
}

class RickMortyCharactersDetailsLoadingState extends RickMortyCharactersDetailsState {
  @override
  List<Object> get props => [];
}

class RickMortyCharactersDetailsLoadedState extends RickMortyCharactersDetailsState {
  RickMortyCharactersDetailsLoadedState({
    this.characterDetails,
  });

  final Character? characterDetails;

  @override
  List<Object?> get props => [characterDetails];

}

class RickMortyCharactersDetailsErrorState extends RickMortyCharactersDetailsState {
  @override
  List<Object> get props => [];
}

