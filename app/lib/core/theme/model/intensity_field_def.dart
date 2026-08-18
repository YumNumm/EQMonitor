import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';

enum IntensityFieldGroup {
  intensity(
    description: '震度アイコンや地震履歴の地域別塗りつぶし等で利用します',
    hasForeground: true,
  ),
  estimatedIntensity(
    description: '最大震度5弱以上を観測する地震が発生した時に発表される推計震度分布図の塗りつぶしで利用します',
    // 推計震度は分布図の塗りつぶしのみで文字を描画しないため文字色を持たない
    hasForeground: false,
  );

  new({required this.description, required this.hasForeground});

  final String description;
  final bool hasForeground;
}

class IntensityFieldDef {
  const new({
    required this.label,
    required this.group,
    required this.entryGetter,
    required this.entrySetter,
  });

  final String label;
  final IntensityFieldGroup group;
  final IntensityColorEntry Function(ThemeColorSet colorSet) entryGetter;
  final ThemeColorSet Function(
    ThemeColorSet colorSet,
    IntensityColorEntry entry,
  )
  entrySetter;
}

/// [IntensityFieldDef]の宣言的な一覧を保持するコンテナ。
///
/// `IntensityColors`(11件)/`EstimatedIntensityColors`(6件)の
/// 全エントリを網羅する。エディタUI(Task 5/6)は[all]を描画するだけで完結する。
class IntensityFieldDefs {
  const new _();

  static final List<IntensityFieldDef> all = [
    IntensityFieldDef(
      label: '震度不明',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.unknown,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(unknown: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度0',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.zero,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(zero: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度1',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.one,
      entrySetter: (colorSet, entry) =>
          colorSet.copyWith(intensity: colorSet.intensity.copyWith(one: entry)),
    ),
    IntensityFieldDef(
      label: '震度2',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.two,
      entrySetter: (colorSet, entry) =>
          colorSet.copyWith(intensity: colorSet.intensity.copyWith(two: entry)),
    ),
    IntensityFieldDef(
      label: '震度3',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.three,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(three: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度4',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.four,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(four: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度5弱',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.fiveLower,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(fiveLower: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度5強',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.fiveUpper,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(fiveUpper: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度6弱',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.sixLower,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(sixLower: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度6強',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.sixUpper,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(sixUpper: entry),
      ),
    ),
    IntensityFieldDef(
      label: '震度7',
      group: IntensityFieldGroup.intensity,
      entryGetter: (colorSet) => colorSet.intensity.seven,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        intensity: colorSet.intensity.copyWith(seven: entry),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度4',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.four,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(four: entry),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度5弱',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.fiveLower,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(
          fiveLower: entry,
        ),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度5強',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.fiveUpper,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(
          fiveUpper: entry,
        ),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度6弱',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.sixLower,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(
          sixLower: entry,
        ),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度6強',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.sixUpper,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(
          sixUpper: entry,
        ),
      ),
    ),
    IntensityFieldDef(
      label: '推計震度7',
      group: IntensityFieldGroup.estimatedIntensity,
      entryGetter: (colorSet) => colorSet.estimatedIntensity.seven,
      entrySetter: (colorSet, entry) => colorSet.copyWith(
        estimatedIntensity: colorSet.estimatedIntensity.copyWith(seven: entry),
      ),
    ),
  ];
}
