import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:material_ui/material_ui.dart';

/// 遠地地震 (海外地震情報) のベースカラー(青)。
const earthquakeDistantColor = Color(0xFF1976D2);

/// 火山噴火 (海外の大規模な噴火) のベースカラー(赤)。
const earthquakeVolcanoColor = Color(0xFFD32F2F);

extension EarthquakeTypeAppearance on EarthquakeType {
  /// 地震種別を表すベースカラー。
  /// 通常の地震は最大震度の色を用いるため `null`。
  Color? get baseColor => switch (this) {
    .normal => null,
    .distant => earthquakeDistantColor,
    .volcano => earthquakeVolcanoColor,
  };

  /// 地震種別を表すアイコン。
  /// 通常の地震は震度アイコンを用いるため `null`。
  IconData? get iconData => switch (this) {
    .normal => null,
    .distant => Icons.public,
    .volcano => Icons.volcano,
  };
}

/// 海外地震情報・火山噴火用のアイコン。
///
/// 震度アイコン(`JmaIntensityIcon`の`.filled`)と同じ角丸矩形の見た目に揃え、
/// ベースカラーの中にアイコンを白で表示する。
/// [EarthquakeType.normal] は専用アイコンを持たないため何も表示しない。
class EarthquakeTypeIcon extends StatelessWidget {
  const EarthquakeTypeIcon({required this.type, required this.size, super.key});

  final EarthquakeType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return switch ((type.baseColor, type.iconData)) {
      (final Color color, final IconData icon) => SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size / 5),
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: size * 0.7),
          ),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
