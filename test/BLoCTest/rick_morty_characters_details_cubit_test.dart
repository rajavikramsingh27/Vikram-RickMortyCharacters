

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/BLoC/RickMortyCharactersDetails/rick_morty_characters_details_cubit.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersDetailsRepo.dart';
import 'package:bloc_test/bloc_test.dart';


void main() {
  group('Successful BLoC test', () {
    late RickMortyCharactersDetailsCubit cubit;
    RickMortyCharactersDetailsRepo repo;

    final mockCharacter = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z");

    setUp(() {
      EquatableConfig.stringify = true;
      repo = RickMortyCharactersDetailsRepo(id: 1);
      cubit = RickMortyCharactersDetailsCubit(di_RickMortyCharactersDetailsRepo: repo);
    });

    blocTest<RickMortyCharactersDetailsCubit, RickMortyCharactersDetailsState>(
      'emits [LoadingState, LoadedState] states for successful task loads',
      build: () => cubit,
      act: (cubit) => cubit.getCharacterPage(),
      expect: () => [
        RickMortyCharactersDetailsLoadingState(),
        RickMortyCharactersDetailsLoadedState(characterDetails: mockCharacter)
      ],
    );

    tearDown(() {
      cubit.close();
    });
  });
}


