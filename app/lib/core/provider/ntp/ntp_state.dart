import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_state.freezed.dart';
part 'ntp_state.g.dart';

@freezed
abstract class NtpState with _$NtpState {
  const factory({
    required Duration offset,
    required DateTime updatedAt,
  }) = _NtpState;

  factory fromJson(Map<String, dynamic> json) => _$NtpStateFromJson(json);
}
