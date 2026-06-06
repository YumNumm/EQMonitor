import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

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
class IntensityRegionDiffEntry {
  const IntensityRegionDiffEntry({
    required this.code,
    required this.name,
    required this.intensity,
    required this.diffType,
    this.previousIntensity,
  });

  /// 地域コード
  final String code;

  /// 地域名
  final String name;

  /// 現報の震度
  final api.JmaIntensity intensity;

  /// 差分種別
  final IntensityDiffType diffType;

  /// 前報の震度 (upgraded / downgraded の場合のみ)
  final api.JmaIntensity? previousIntensity;

  @override
  String toString() =>
      'IntensityRegionDiffEntry(code=$code, name=$name, '
      'intensity=$intensity, diffType=$diffType, '
      'previousIntensity=$previousIntensity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntensityRegionDiffEntry &&
          code == other.code &&
          name == other.name &&
          intensity == other.intensity &&
          diffType == other.diffType &&
          previousIntensity == other.previousIntensity;

  @override
  int get hashCode => Object.hash(code, name, intensity, diffType, previousIntensity);
}

/// 震源要素の差分情報
class HypocenterDiff {
  const HypocenterDiff({
    this.oldMagnitude,
    this.newMagnitude,
    this.oldDepth,
    this.newDepth,
    this.oldEpicenterName,
    this.newEpicenterName,
    this.oldMaxIntensity,
    this.newMaxIntensity,
  });

  final String? oldMagnitude;
  final String? newMagnitude;

  final num? oldDepth;
  final num? newDepth;

  final String? oldEpicenterName;
  final String? newEpicenterName;

  final api.JmaIntensity? oldMaxIntensity;
  final api.JmaIntensity? newMaxIntensity;

  bool get hasMagnitudeChange => oldMagnitude != newMagnitude;
  bool get hasDepthChange => oldDepth != newDepth;
  bool get hasEpicenterNameChange => oldEpicenterName != newEpicenterName;
  bool get hasMaxIntensityChange => oldMaxIntensity != newMaxIntensity;

  bool get hasAnyChange =>
      hasMagnitudeChange ||
      hasDepthChange ||
      hasEpicenterNameChange ||
      hasMaxIntensityChange;

  @override
  String toString() =>
      'HypocenterDiff('
      'magnitude=$oldMagnitude->$newMagnitude, '
      'depth=$oldDepth->$newDepth, '
      'epicenter=$oldEpicenterName->$newEpicenterName, '
      'maxIntensity=$oldMaxIntensity->$newMaxIntensity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HypocenterDiff &&
          oldMagnitude == other.oldMagnitude &&
          newMagnitude == other.newMagnitude &&
          oldDepth == other.oldDepth &&
          newDepth == other.newDepth &&
          oldEpicenterName == other.oldEpicenterName &&
          newEpicenterName == other.newEpicenterName &&
          oldMaxIntensity == other.oldMaxIntensity &&
          newMaxIntensity == other.newMaxIntensity;

  @override
  int get hashCode => Object.hash(
        oldMagnitude,
        newMagnitude,
        oldDepth,
        newDepth,
        oldEpicenterName,
        newEpicenterName,
        oldMaxIntensity,
        newMaxIntensity,
      );
}

/// [JmaIntensity] を比較可能な整数に変換する
int _intensityOrder(api.JmaIntensity intensity) {
  return switch (intensity) {
    api.JmaIntensity.value0 => 0,
    api.JmaIntensity.value1 => 1,
    api.JmaIntensity.value2 => 2,
    api.JmaIntensity.value3 => 3,
    api.JmaIntensity.value4 => 4,
    api.JmaIntensity.value5unknown => 5,
    api.JmaIntensity.value5minus => 6,
    api.JmaIntensity.value5plus => 7,
    api.JmaIntensity.value6minus => 8,
    api.JmaIntensity.value6plus => 9,
    api.JmaIntensity.value7 => 10,
  };
}

/// 2つの震度地域リストの差分を計算する
///
/// [current] が現報、[previous] が前報の震度地域リスト。
/// [previous] が null または空の場合は初報扱いで全て [IntensityDiffType.same]。
List<IntensityRegionDiffEntry> computeIntensityRegionDiff({
  required List<api.EarthquakeTelegramBodyIntensityRegion> current,
  List<api.EarthquakeTelegramBodyIntensityRegion>? previous,
}) {
  // intensity が null のエントリは除外
  final currentFiltered =
      current.where((e) => e.intensity != null).toList();

  if (previous == null || previous.isEmpty) {
    // 初報: 全て same
    return [
      for (final entry in currentFiltered)
        IntensityRegionDiffEntry(
          code: entry.code,
          name: entry.name,
          intensity: entry.intensity!,
          diffType: IntensityDiffType.same,
        ),
    ];
  }

  // 前報を code -> intensity のマップに変換 (intensity が null のものは除外)
  final previousMap = <String, api.JmaIntensity>{};
  for (final entry in previous) {
    if (entry.intensity != null) {
      previousMap[entry.code] = entry.intensity!;
    }
  }

  return [
    for (final entry in currentFiltered)
      () {
        final prevIntensity = previousMap[entry.code];
        if (prevIntensity == null) {
          // 前報に存在しない -> 追加
          return IntensityRegionDiffEntry(
            code: entry.code,
            name: entry.name,
            intensity: entry.intensity!,
            diffType: IntensityDiffType.added,
          );
        }

        final currentOrder = _intensityOrder(entry.intensity!);
        final previousOrder = _intensityOrder(prevIntensity);

        if (currentOrder > previousOrder) {
          return IntensityRegionDiffEntry(
            code: entry.code,
            name: entry.name,
            intensity: entry.intensity!,
            diffType: IntensityDiffType.upgraded,
            previousIntensity: prevIntensity,
          );
        } else if (currentOrder < previousOrder) {
          return IntensityRegionDiffEntry(
            code: entry.code,
            name: entry.name,
            intensity: entry.intensity!,
            diffType: IntensityDiffType.downgraded,
            previousIntensity: prevIntensity,
          );
        } else {
          return IntensityRegionDiffEntry(
            code: entry.code,
            name: entry.name,
            intensity: entry.intensity!,
            diffType: IntensityDiffType.same,
          );
        }
      }(),
  ];
}

/// 2つの震源要素の差分を計算する
///
/// 差分がない場合は null を返す。
HypocenterDiff? computeHypocenterDiff({
  required api.EarthquakeTelegramBodyQuake? current,
  api.EarthquakeTelegramBodyQuake? previous,
}) {
  if (current == null) {
    return null;
  }

  final diff = HypocenterDiff(
    oldMagnitude: previous?.magnitude,
    newMagnitude: current.magnitude,
    oldDepth: previous?.depth,
    newDepth: current.depth,
    oldEpicenterName: previous?.epicenterName,
    newEpicenterName: current.epicenterName,
    oldMaxIntensity: previous?.maxIntensity,
    newMaxIntensity: current.maxIntensity,
  );

  if (!diff.hasAnyChange) {
    return null;
  }

  return diff;
}
