// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pole_paris_app/models/base.dart';

class Alert extends BaseModel {
  final String title;
  final String content;
  final String htmlContent;
  final bool read;
  const Alert({
    required this.title,
    required this.content,
    required this.htmlContent,
    required this.read,
    required super.id,
    required super.dateCreatedUtc,
  });

  Alert copyWith({
    String? id,
    DateTime? dateCreatedUtc,
    String? title,
    String? content,
    String? htmlContent,
    bool? read,
  }) {
    return Alert(
      id: id ?? this.id,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
      title: title ?? this.title,
      content: content ?? this.content,
      htmlContent: htmlContent ?? this.htmlContent,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
      'title': title,
      'content': content,
      'htmlContent': htmlContent,
      'read': read,
    };
  }

  factory Alert.fromMap(Map<String, dynamic> map) {
    return Alert(
      id: map['id'] as String,
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
      title: map['title'] as String,
      content: map['content'] as String,
      htmlContent: map['htmlContent'] as String,
      read: map['read'] as bool,
    );
  }
}
