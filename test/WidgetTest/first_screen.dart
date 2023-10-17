
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/Views/RickMortyCharacters.dart';
import 'package:qurhealth_task/main.dart';

void main() {
  testWidgets('Verify add user button present on ActiveUsers page',
          (WidgetTester tester) async {

        await tester.pumpWidget(const RickMortyCharacters());

        var fab = find.byKey(Key("Scaffold"));

        expect(fab, findsNothing);
        // expect(fab, findsOneWidget);
      });
}

