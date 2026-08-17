import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_body_diff.freezed.dart';
part 'earthquake_body_diff.g.dart';

/// 震度地域の差分種別
enum IntensityDiffType {
  /// 前報と同じ
  same,

  /// 新たに追加された地域
  added,

  /// 震度が上方修正された
  upgraded,

  /// 震度が下方修正された
  downgraded,
}

/// 震度地域の差分情報
@freezed
abstract class IntensityRegionDiffEntry with _$IntensityRegionDiffEntry {
  const factory({
    required String code,
    required String name,
    required JmaIntensity intensity,
    required IntensityDiffType diffType,
    JmaIntensity? previousIntensity,
  }) = _IntensityRegionDiffEntry;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionDiffEntryFromJson(json);
}

/// 震源要素の差分情報
@freezed
abstract class HypocenterDiff with _$HypocenterDiff {
  const factory({
    String? oldMagnitude,
    String? newMagnitude,
    num? oldDepth,
    num? newDepth,
    String? oldEpicenterName,
    String? newEpicenterName,
    JmaIntensity? oldMaxIntensity,
    JmaIntensity? newMaxIntensity,
  }) = _HypocenterDiff;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$HypocenterDiffFromJson(json);

  bool hasMagnitudeChange() =>
      oldMagnitude != null &&
      newMagnitude != null &&
      oldMagnitude != newMagnitude;
  bool hasDepthChange() =>
      oldDepth != null && newDepth != null && oldDepth != newDepth;
  bool hasEpicenterNameChange() =>
      oldEpicenterName != null &&
      newEpicenterName != null &&
      oldEpicenterName != newEpicenterName;
  bool hasMaxIntensityChange() => oldMaxIntensity != newMaxIntensity;

  bool hasAnyChange() =>
      hasMagnitudeChange() ||
      hasDepthChange() ||
      hasEpicenterNameChange() ||
      hasMaxIntensityChange();
}
