import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'required_version_model.freezed.dart';

@freezed
abstract class RequiredVersionModel with _$RequiredVersionModel {
  const factory RequiredVersionModel({
    String? version,
    int? buildNumber,
    String? message,
  }) = _RequiredVersionModel;
}

extension RequiredVersionApiExtension on api.RequiredVersion {
  RequiredVersionModel toRequiredVersionModel() => RequiredVersionModel(
    version: version,
    buildNumber: buildNumber,
    message: message,
  );
}
