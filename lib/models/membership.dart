// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/class.dart';

class Membership extends BaseModel {
  final MembershipType type;
  final DateTime expirationDate;
  final int? entries;
  List<Class>? classes;
  Membership({
    required super.id,
    required this.type,
    required this.expirationDate,
    this.entries,
    this.classes,
    required super.dateCreatedUtc,
  });

  Membership copyWith({
    MembershipType? type,
    DateTime? expirationDate,
    int? entries,
    List<Class>? classes,
    String? id,
    DateTime? dateCreatedUtc,
  }) {
    return Membership(
        id: id ?? this.id,
        type: type ?? this.type,
        expirationDate: expirationDate ?? this.expirationDate,
        entries: entries ?? this.entries,
        classes: classes ?? this.classes,
        dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': _$MembershipTypeEnumMap[type],
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'entries': entries,
      'classes': classes?.map((x) => x.toMap()).toList(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory Membership.fromMap(Map<String, dynamic> map) {
    return Membership(
      id: map['id'] as String,
      type: $enumDecode(_$MembershipTypeEnumMap, map['type']),
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      entries: map['entries'] != null ? map['entries'] as int : null,
      classes: map['classes'] != null
          ? List<Class>.from(
              (map['classes'] as List<dynamic>).map<Class>(
                (x) => Class.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }
}

enum MembershipType {
  @JsonValue("base")
  base,
  @JsonValue("singleUse")
  singleUse,
  @JsonValue("premium")
  premium,
}

extension MembershipExtension on MembershipType {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case MembershipType.singleUse:
        return 'Karnet jednorazowy';
      case MembershipType.premium:
        return 'Karnet premium';
      case MembershipType.base:
      default:
        return 'Karnet podstawowy';
    }
  }
}

const _$MembershipTypeEnumMap = {
  MembershipType.base: 'base',
  MembershipType.singleUse: 'singleUse',
  MembershipType.premium: 'premium',
};
