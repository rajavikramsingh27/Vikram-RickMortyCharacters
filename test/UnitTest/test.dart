// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersRepo.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';
import 'package:qurhealth_task/Utils/HiveDBKonstants.dart';

import 'dart:async';


void main() {
  group("description", ()  {
    test('Testing API calling', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      Directory document = await getApplicationDocumentsDirectory();
      print(document.path);

      print(HiveDBKonstants.RickMorty.toString());

      Hive.init(document.path);

      await Hive.openBox(HiveDBKonstants.RickMorty.value);

      final url = kBaseURL+ APIEndPoints.character_page.value;
      final api = API(url: "$url=1");
      final response = await api.get();

      expect(response.statusCode, 200);
    });

    test("ProductRepo.getCharacterPage", () async {
      final rickMortyCharactersRepo = RickMortyCharactersRepo();

      final url = kBaseURL + APIEndPoints.character_page.value;
      final arrCharacter = await rickMortyCharactersRepo.getCharacterPage(url: url, page: 1, endPointsFilter: "");

      expect(arrCharacter!.isNotEmpty, true);
    });

  });
}
