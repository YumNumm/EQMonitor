import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_model.freezed.dart';

@freezed
class NtpModel with _$NtpModel {
  const factory NtpModel({
    required int delay,
    required DateTime lastUpdatedAt,
  }) = _NtpModel;
}
