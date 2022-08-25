import 'package:freezed_annotation/freezed_annotation.dart';

part 'developer_mode_model.freezed.dart';

@freezed
class DeveloperModeModel with _$DeveloperModeModel {
  const factory DeveloperModeModel({
    required bool isDeveloper,
  }) = _DeveloperModeModel;
}
