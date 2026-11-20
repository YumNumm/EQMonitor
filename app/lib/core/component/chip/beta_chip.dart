import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:material_ui/material_ui.dart';

/// ベータ提供中の機能に付ける「BETA」チップ。
///
/// 開発用アプリアイコンのチップ（白地・角丸・青の太字）と同じ比率と色で描く。
/// テーマには追従させず、明るい背景でも輪郭が分かるよう細い枠を付ける。
/// 文字サイズ・角丸・左右の余白は [height] に比例するため、
/// 端末の文字サイズ設定には追従させない。
class const BetaChip({final double height = 18, super.key})
    extends StatelessWidget {
  static const _foreground = Color(0xFF0032CE);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'ベータ',
      excludeSemantics: true,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: height * 0.3),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(height * 0.34),
            side: BorderSide(
              color: _foreground.withValues(alpha: 0.24),
              width: 0.5,
            ),
          ),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            'BETA',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontFamily: FontFamily.googleSansFlex,
              fontSize: height * 0.72,
              height: 1,
              color: _foreground,
              fontWeight: .w900,
              fontVariations: const [FontVariation.weight(900)],
              leadingDistribution: .even,
            ),
          ),
        ),
      ),
    );
  }
}
