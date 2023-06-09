import 'package:flutter/foundation.dart';

enum Levels {
  primary,
  advanced,
  all,
}

extension LevelsExtension on Levels {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case Levels.primary:
        return 'Początkujący';
      case Levels.advanced:
        return 'Zaawansowany';
      case Levels.all:
      default:
        return 'Wszystkie poziomy';
    }
  }
}
