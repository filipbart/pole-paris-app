// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';

// ignore: must_be_immutable
class Membership extends BaseModel {
  final String name;
  final MembershipType type;
  final int validDays;
  final int price;
  final int? poleEntries;
  final int? fitnessEntries;
  Membership({
    required super.id,
    required this.name,
    required this.type,
    required this.validDays,
    required this.price,
    this.poleEntries,
    this.fitnessEntries,
    required super.dateCreatedUtc,
  });

  Membership copyWith({
    String? name,
    MembershipType? type,
    int? validDays,
    int? price,
    int? poleEntries,
    int? fitnessEntries,
    String? id,
    DateTime? dateCreatedUtc,
  }) {
    return Membership(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        validDays: validDays ?? this.validDays,
        price: price ?? this.price,
        poleEntries: poleEntries ?? this.poleEntries,
        fitnessEntries: fitnessEntries ?? this.fitnessEntries,
        dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': _$MembershipTypeEnumMap[type],
      'validDays': validDays,
      'price': price,
      'poleEntries': poleEntries,
      'fitnessEntries': fitnessEntries,
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory Membership.fromMap(Map<String, dynamic> map) {
    return Membership(
      id: map['id'] as String,
      name: map['name'] as String,
      type: $enumDecode(_$MembershipTypeEnumMap, map['type']),
      validDays: map['validDays'] as int,
      price: map['price'] as int,
      poleEntries:
          map['poleEntries'] != null ? map['poleEntries'] as int : null,
      fitnessEntries:
          map['fitnessEntries'] != null ? map['fitnessEntries'] as int : null,
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }
}

enum MembershipType {
  @JsonValue("pole")
  pole,
  @JsonValue("stretchFitness")
  stretchFitness,
  @JsonValue("all")
  all
}

const _$MembershipTypeEnumMap = {
  MembershipType.pole: 'pole',
  MembershipType.stretchFitness: 'stretchFitness',
  MembershipType.all: 'all',
};
