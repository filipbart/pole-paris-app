import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue("teacher")
  teacher,
  @JsonValue("student")
  student
}
