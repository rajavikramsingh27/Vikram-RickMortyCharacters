
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/Models/Character.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersDetailsRepo.dart';
import 'package:qurhealth_task/Utils/API.dart';
import 'package:qurhealth_task/Utils/APIEndPoints.dart';

void main() {
  group("description", () {

    test('Testing API calling', () async {
      final url = "${kBaseURL+ APIEndPoints.character_page.value}/1";

      final api = API(url: url);
      final response = await api.get();

      expect(response.statusCode, 200);
    });

    test('RickMortyCharactersDetailsRepo getCharacterDetails', () async {
      final obj = RickMortyCharactersDetailsRepo(id: 1);
      final data = await obj.getCharacterDetails();

      final mockCharacter = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z");

      expect(data, mockCharacter);
    });

  });
}
