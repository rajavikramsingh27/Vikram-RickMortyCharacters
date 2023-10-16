import 'package:bloc/bloc.dart';

import '../Models/Character.dart';
import '../Repository/RickMortyCharactersRepo.dart';

part 'rick_morty_characters_state.dart';

class RickMortyCharactersCubit extends Cubit<RickMortyCharactersState> {
  RickMortyCharactersCubit() : super(RickMortyCharactersInitial());

  List<Character> arrProductList = [];

  void getCharacterPage(int page) async {
    try {
      emit(LoadingState());

      final data = await RickMortyCharactersRepo.getCharacterPage(page: page);

      if (data is List<Character>) {
        arrProductList = data;

        emit(LoadedState(
          arrProductList: arrProductList,
        ));
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
