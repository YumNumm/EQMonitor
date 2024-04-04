import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_state_model.freezed.dart';
part 'ntp_state_model.g.dart';

@freezed
class NtpStateModel with _$NtpStateModel {
  const factory NtpStateModel({
    int? offset,
    DateTime? updatedAt,
  }) = _NtpStateModel;

  factory NtpStateModel.fromJson(Map<String, dynamic> json) =>
      _$NtpStateModelFromJson(json);
}
