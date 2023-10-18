import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qurhealth_task/Utils/HiveDB.dart';
import 'package:qurhealth_task/Utils/HiveDBKonstants.dart';

import '../Models/Character.dart';
import '../Repository/RickMortyCharactersRepo.dart';
import '../Utils/CheckInternet.dart';

part 'rick_morty_characters_state.dart';

class RickMortyCharactersCubit extends Cubit<RickMortyCharactersState> {
  RickMortyCharactersCubit({required this.di_RickMortyCharactersRepo})
      : super(RickMortyCharactersInitial());

  final DI_RickMortyCharactersRepo di_RickMortyCharactersRepo;

  List<Character> arrProductList = [];
  int pageCount = 1;

  void getCharacterPage(
      {required String url,
      required int page,
      bool isLoader = true,
      String endPointsFilter = ""}) async {
    try {
      if (isLoader) {
        emit(RickMortyCharactersLoadingState());
      }

      final data = await di_RickMortyCharactersRepo.getCharacterPage(
          url: url, page: page, endPointsFilter: endPointsFilter);

      if (data is List<Character>) {
        data.forEach((element) {
          final hiveDB = HiveDB(dbName: HiveDBKonstants.RickMorty.value);
          hiveDB.saveData(collection: element);
        });

        if (arrProductList.isEmpty) {
          arrProductList = data;
        } else {
          arrProductList = data + arrProductList;
        }

        print(arrProductList.length);

        emit(RickMortyCharactersLoadedState(
          arrCharacterList: arrProductList,
        ));
      }
    } catch (e) {
      emit(RickMortyCharactersErrorState());
    }
  }
}
