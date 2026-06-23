import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_result.freezed.dart';

@freezed
abstract class UploadResult with _$UploadResult {
  const factory UploadResult({
    required int sentCount,
    required int failedCount,
  }) = _UploadResult;
}
