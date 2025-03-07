import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_state.freezed.dart';
part 'permission_state.g.dart';

@freezed
class PermissionStateModel with _$PermissionStateModel {
  const factory PermissionStateModel({
    @Default(false) bool notification,
    @Default(false) bool criticalAlert,
    @Default(false) bool location,
    @Default(false) bool backgroundLocation,
  }) = _PermissionStateModel;

  factory PermissionStateModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionStateModelFromJson(json);
}
