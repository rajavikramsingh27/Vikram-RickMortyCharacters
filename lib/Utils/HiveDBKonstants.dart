enum HiveDBKonstants { RickMorty }

extension HiveDBKonstantsValues on HiveDBKonstants {
  String get value {
    switch (this) {
      case HiveDBKonstants.RickMorty:
        return 'RickMorty';
    }
  }
}
