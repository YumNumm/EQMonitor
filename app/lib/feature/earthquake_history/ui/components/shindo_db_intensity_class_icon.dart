import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';

extension ShindoDbIntensityClassMapIconId on ShindoDbIntensityClass {
  /// 地図スタイルに登録された観測点アイコン画像の ID
  ///
  /// 現行の JMA 震度と一致する階級は [JmaIntensityIcon] 由来の画像を流用し、
  /// 旧階級 (5/6) と歴史的階級は [ShindoDbIntensityClassMapIcon] 由来の
  /// 専用画像を参照する。
  String get mapIconId {
    final exact = exactJmaIntensity;
    return exact != null
        ? 'JmaIntensity.${IntensityIconType.small.name}.${exact.name}'
        : 'ShindoDbIntensityClass.${IntensityIconType.small.name}.$name';
  }

  /// 地図スタイルに登録されたラベルなし観測点アイコン画像の ID
  ///
  /// 色だけでは分類できない歴史的階級は [mapIconId] のラベルを維持する。
  String get plainMapIconId => switch (this) {
    .five =>
      'JmaIntensity.${IntensityIconType.smallWithoutText.name}.fiveUnknown',
    .six =>
      'JmaIntensity.${IntensityIconType.smallWithoutText.name}.sixUnknown',
    _ => switch (exactJmaIntensity) {
      final intensity? =>
        'JmaIntensity.${IntensityIconType.smallWithoutText.name}.${intensity.name}',
      null => mapIconId,
    },
  };
}

/// 震度データベースの震度階級の地図用円形アイコン
///
/// 現行の JMA 震度と一致する階級は [JmaIntensityIcon] をそのまま利用し、
/// 旧階級 (5/6) と歴史的階級はラベルテキスト入りの円を描画する。
class ShindoDbIntensityClassMapIcon extends StatelessWidget {
  const new({
    required this.intensityClass,
    this.size = 50,
    super.key,
  });

  final ShindoDbIntensityClass intensityClass;
  final double size;

  @override
  Widget build(BuildContext context) {
    final exact = intensityClass.exactJmaIntensity;
    if (exact != null) {
      return JmaIntensityIcon(
        intensity: exact,
        type: IntensityIconType.small,
        size: size,
      );
    }

    final colorTheme = context.designSystem.colorTheme;
    final colorJma = intensityClass.colorJmaIntensity;
    final entry = colorJma != null
        ? colorTheme.intensity.fromJmaIntensity(colorJma)
        : null;
    final fg = entry?.resolvedForeground ?? colorTheme.onSurface;
    final bg = entry?.background ?? colorTheme.surfaceContainerHighest;
    final borderColor = Color.lerp(bg, fg, 0.3) ?? fg;
    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          border: Border.all(color: borderColor, width: 5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                intensityClass.label,
                style: TextStyle(
                  color: fg,
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.googleSansCode,
                  fontFamilyFallback: const [FontFamily.notoSansJP],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShindoDbIntensityClassIcon extends StatelessWidget {
  const new({
    required this.intensityClass,
    this.size = 40,
    super.key,
  });

  final ShindoDbIntensityClass intensityClass;
  final double size;

  @override
  Widget build(BuildContext context) {
    final exact = intensityClass.exactJmaIntensity;
    if (exact != null) {
      return JmaIntensityIcon(
        intensity: exact,
        type: IntensityIconType.filled,
        size: size,
      );
    }

    final colorJma = intensityClass.colorJmaIntensity;
    if (colorJma != null) {
      final entry = context.designSystem.colorTheme.intensity.fromJmaIntensity(
        colorJma,
      );
      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: entry.background,
            borderRadius: BorderRadius.circular(size * 0.25),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                intensityClass.label,
                style: TextStyle(
                  color: entry.resolvedForeground,
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.googleSansCode,
                  fontFamilyFallback: const [FontFamily.notoSansJP],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.designSystem.colorTheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(size * 0.25),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              intensityClass.label,
              style: TextStyle(
                color: context.designSystem.colorTheme.onSurface,
                fontSize: size,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: const [FontFamily.notoSansJP],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
