import 'package:flutter/foundation.dart';

enum Level { primary, advanced, all }

extension LevelExtension on Level {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case Level.primary:
        return 'Początkujący';
      case Level.advanced:
        return 'Zaawansowany';
      case Level.all:
      default:
        return 'Wszystkie poziomy';
    }
  }
}

class LevelHelper {
  static Level enumValueByDesc(String description) {
    switch (description) {
      case 'Początkujący':
        return Level.primary;
      case 'Zaawansowany':
        return Level.advanced;
      case 'Wszystkie poziomy':
      default:
        return Level.all;
    }
  }
}
