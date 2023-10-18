
// RickMortyCharactersDetailsRepo



import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Utils/API.dart';

import '../Utils/APIEndPoints.dart';
import '../Utils/CheckInternet.dart';
import '../Utils/HiveDB.dart';
import '../Utils/HiveDBKonstants.dart';

abstract class DI_RickMortyCharactersDetailsRepo {
  Future<Character?> getCharacterDetails();
}

class RickMortyCharactersDetailsRepo implements DI_RickMortyCharactersDetailsRepo {

  RickMortyCharactersDetailsRepo({required this.id});

  final int id;

  @override
  Future<Character?> getCharacterDetails() async {
    if (await CheckInternet.checkInternet()) {
      final url = "${kBaseURL + APIEndPoints.character.value}/$id";

      final api = API(url: url);
      final response = await api.get();

      if (response.statusCode == 200) {
        final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

        final characterDetails = Character.fromJson(dictBody);

        return characterDetails;
      } else {
        return null;
      }
    } else {
      final hiveDB = HiveDB(dbName: HiveDBKonstants.RickMorty.value);
      final dataOfCharacter = hiveDB.getDataByKey(id);

      final characterDetails = Character.fromJson(dataOfCharacter);

      return characterDetails;
    }
  }

}
