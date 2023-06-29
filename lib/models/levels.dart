import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

enum Level {
  @JsonValue("primary")
  primary,
  @JsonValue("base")
  base,
  @JsonValue("intermediate")
  intermediate,
  @JsonValue("all")
  all,
}

extension LevelExtension on Level {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case Level.primary:
        return 'Początkujący';
      case Level.base:
        return 'Podstawowy';
      case Level.intermediate:
        return 'Średniozaawansowany';
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
      case 'Podstawowy':
        return Level.base;
      case 'Średniozaawansowany':
        return Level.intermediate;
      case 'Wszystkie poziomy':
      default:
        return Level.all;
    }
  }
}
