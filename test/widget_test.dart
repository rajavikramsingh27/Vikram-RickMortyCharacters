// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersRepo.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';
import 'package:http/http.dart' as http;

void main() {
  group("description", () {

    test('Testing API calling', () async {
      final url = kBaseURL+ APIEndPoints.character_page.value;
      final api = API(url: "$url=1");
      final response = await api.get();

      expect(response.statusCode, 200);
    });

    test("ProductRepo.getCharacterPage", () async {
      final arrCharacter = await RickMortyCharactersRepo.getCharacterPage(page: 2);

      expect(arrCharacter!.isNotEmpty, true);
    });

  });
}
