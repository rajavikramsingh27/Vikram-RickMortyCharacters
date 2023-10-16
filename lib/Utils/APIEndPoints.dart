
// https://medium.com/@tonia.tkachuk/using-enums-like-a-pro-in-flutter-4563dde2e8a9

enum APIEndPoints {
  character_page,
  character,
}

extension APIEndPoint on APIEndPoints {
  String get value {
    switch (this) {
      case APIEndPoints.character_page:
        return 'character/?page';
      case APIEndPoints.character:
        return 'character';
    }
  }
}

adfsaf() {
  APIEndPoints.character_page.value;
}