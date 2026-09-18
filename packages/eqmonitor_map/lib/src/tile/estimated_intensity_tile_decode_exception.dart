/// 推計震度 tile 全体を拒否した理由。入力 bytes や下位例外は保持しない。
enum EstimatedIntensityTileDecodeFailure {
  invalidMvt,
  resourceLimitExceeded,
  missingSourceLayer,
  duplicateSourceLayer,
  wrongGeometry,
  missingName,
  unknownClass,
  invalidGeometry,
}

final class EstimatedIntensityTileDecodeException implements Exception {
  const new(this.failure);

  final EstimatedIntensityTileDecodeFailure failure;

  @override
  String toString() =>
      'EstimatedIntensityTileDecodeException(failure: $failure)';
}
