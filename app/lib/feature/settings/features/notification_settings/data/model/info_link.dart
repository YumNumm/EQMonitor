import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_link.freezed.dart';

@freezed
abstract class InfoLink with _$InfoLink {
  const factory InfoLink({
    required String title,
    required String url,
  }) = _InfoLink;
}
