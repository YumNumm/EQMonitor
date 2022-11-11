import 'package:json_annotation/json_annotation.dart';

part 'information.g.dart';

// CREATE TABLE IF NOT EXISTS public.information(
//   id UUID PRIMARY KEY DEFAULT uuid_generate_v7() NOT NULL,
//   title TEXT NOT NULL DEFAULT '',
//   body TEXT NOT NULL DEFAULT '',
//   author TEXT NOT NULL DEFAULT 'Developer',
//   tags TEXT[],
//   created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
// );

@JsonSerializable()
class Information {
  Information({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.tags,
    required this.createdAt,
  });

  factory Information.fromJson(Map<String, dynamic> json) =>
      _$InformationFromJson(json);

  final String id;
  final String title;
  final String body;
  final String author;
  final List<String> tags;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$InformationToJson(this);
}
