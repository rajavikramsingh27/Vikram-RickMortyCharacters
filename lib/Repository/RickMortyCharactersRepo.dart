
// https://medium.com/flutter-community/bloc-testing-write-your-first-simple-unit-test-in-flutter-1eee1d1642aa

import 'dart:developer';

import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';
import 'package:qurhealth_task/Utils/HiveDB.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';
import 'package:qurhealth_task/Utils/HiveDBKonstants.dart';

import '../Utils/CheckInternet.dart';

abstract class DI_RickMortyCharactersRepo {
  Future<List<Character>?> getCharacterPage({required String url, required int page, required String endPointsFilter});
}

class RickMortyCharactersRepo implements DI_RickMortyCharactersRepo {

  @override
  Future<List<Character>?> getCharacterPage({required String url, required int page, required String endPointsFilter}) async {

    if (await CheckInternet.checkInternet()) {
      if (endPointsFilter.isEmpty) {
        url = "$url=$page";
      } else {
        url = "$url=$page$endPointsFilter";
      }

      print(url);

      final api = API(url: url);
      final response = await api.get();

      if (response.statusCode == 200) {
        final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));
        final arrResults = List<Map<String, dynamic>>.from(dictBody['results']);

        return List<Character>.from(arrResults.map((x) => Character.fromJson(x)));
      } else {
        return null;
      }
    } else {
      final hiveDB = HiveDB(dbName: HiveDBKonstants.RickMorty.value);
      final arrHiveDBAllData = hiveDB.getAllData();

      return List<Character>.from(arrHiveDBAllData.map((x) => Character.fromJson(x)));
    }

  }

}
