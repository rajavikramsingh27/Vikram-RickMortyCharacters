import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qurhealth_task/Views/RickMortyCharactersDetails.dart';

import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';

void main() {
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Login Page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: new RickMortyCharactersDetails(id: 1,)));

    final detailsContainer = find.byKey(Key("detailsContainer"));
    expect(detailsContainer, findsOneWidget);

    final image = find.byKey(Key("image"));
    expect(image, findsOneWidget);

    final name = find.byKey(Key("name"));
    expect(name, findsOneWidget);

    final status = find.byKey(Key("status"));
    expect(status, findsOneWidget);

    final gender = find.byKey(Key("gender"));
    expect(gender, findsOneWidget);
  });
}
