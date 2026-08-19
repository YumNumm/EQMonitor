import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_state.freezed.dart';
part 'ntp_state.g.dart';

@freezed
abstract class NtpState({
  required final Duration offset,
  required final DateTime updatedAt,
}) with _$NtpState {
  factory fromJson(Map<String, dynamic> json) => _$NtpStateModelFromJson(json);
}
