import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue("instructor")
  teacher,
  @JsonValue("student")
  student
}
