

import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';

class RickMortyCharactersRepo {
  static Future<List<Character>?> getCharacterPage({required int page}) async {
    final url = kBaseURL+ APIEndPoints.character_page.value;
    final api = API(url: "$url=$page");
    final response = await api.get();

    if (response.statusCode == 200) {
      final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));
      final arrResults = List<Map<String, dynamic>>.from(dictBody['results']);

      return List<Character>.from(arrResults.map((x) => Character.fromJson(x)));
    } else {
      return null;
    }
  }

}
