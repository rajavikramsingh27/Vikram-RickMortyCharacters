import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersDetailsRepo.dart';

import '../../Models/Character.dart';

part 'rick_morty_characters_details_state.dart';

class RickMortyCharactersDetailsCubit
    extends Cubit<RickMortyCharactersDetailsState> {
  // RickMortyCharactersDetailsCubit(
  //     {required this.di_RickMortyCharactersDetailsRepo})
  //     : super(RickMortyCharactersDetailsInitial());

  RickMortyCharactersDetailsCubit()
      : super(RickMortyCharactersDetailsInitial());

  // final DI_RickMortyCharactersDetailsRepo di_RickMortyCharactersDetailsRepo;
  RickMortyCharactersDetailsRepo? di_RickMortyCharactersDetailsRepo;

  void getCharacterPage() async {
    try {
      emit(RickMortyCharactersDetailsLoadingState());

      final data =
          await di_RickMortyCharactersDetailsRepo!.getCharacterDetails();

      if (data is Character) {
        emit(RickMortyCharactersDetailsLoadedState(
          characterDetails: data,
        ));
      }
    } catch (e) {
      emit(RickMortyCharactersDetailsErrorState());
    }
  }
}
