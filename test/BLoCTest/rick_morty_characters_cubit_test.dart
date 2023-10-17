

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/BLoC/rick_morty_characters_cubit.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersRepo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';

void main() {
  group('Successful BLoC test', () {
    late RickMortyCharactersCubit taskCubit;
    RickMortyCharactersRepo mockTaskRepository;

    final url = kBaseURL + APIEndPoints.character_page.value;

    setUp(() {
      EquatableConfig.stringify = true;
      mockTaskRepository = RickMortyCharactersRepo();
      taskCubit = RickMortyCharactersCubit(di_RickMortyCharactersRepo: mockTaskRepository);
    });
    
    blocTest<RickMortyCharactersCubit, RickMortyCharactersState>(
      'emits [LoadingState, LoadedState] states for successful task loads',
      build: () => taskCubit,
      act: (cubit) => cubit.getCharacterPage(url: url, page: 1),
      expect: () => [
        RickMortyCharactersLoadingState(),
        RickMortyCharactersLoadedState()
      ],
    );
    
    tearDown(() {
      taskCubit.close();
    });
  });
}


