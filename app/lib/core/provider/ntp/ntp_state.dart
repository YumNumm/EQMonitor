import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_state.freezed.dart';
part 'ntp_state.g.dart';

@freezed
abstract class NtpState with _$NtpState {
  const factory({int? offset, DateTime? updatedAt}) = _NtpStateModel;

  factory fromJson(Map<String, dynamic> json) =>
      _$NtpStateModelFromJson(json);
}
