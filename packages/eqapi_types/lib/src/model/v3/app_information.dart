import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_information.freezed.dart';
part 'app_information.g.dart';

@freezed
abstract class AppInformation with _$AppInformation {
  const factory AppInformation({
    required String version,
    required String buildNumber,
    String? message,
  }) = _AppInformation;

  factory AppInformation.fromJson(Map<String, dynamic> json) =>
      _$AppInformationFromJson(json);
}
