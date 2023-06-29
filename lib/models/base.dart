// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class BaseModel extends Equatable {
  final String id;
  final DateTime dateCreatedUtc;
  const BaseModel({
    required this.id,
    required this.dateCreatedUtc,
  });

  @override
  List<Object?> get props => [
        id,
        dateCreatedUtc,
      ];
}
