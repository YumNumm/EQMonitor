import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_info_text_style.dart';
import 'package:material_ui/material_ui.dart';

/// [MagnitudeText] の表示バリアント。
enum MagnitudeTextVariant {
  /// 一行のインライン表示。`M`と数値を一続きで表示する。
  /// リスト末尾などの省スペース用途。
  compact,

  /// `M`ラベルと値を分けて大きく見せる表示。
  /// 詳細カードなどの強調用途。
  display,
}

/// マグニチュードを表示する Widget。
///
/// [variant] により表示の粒度を切り替える。
class const MagnitudeText({
  required final EarthquakeMagnitude? magnitude,
  final MagnitudeTextVariant variant = MagnitudeTextVariant.compact,

  /// 文字色の上書き。[MagnitudeTextVariant.compact] でのみ有効。
  final Color? color,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      MagnitudeTextVariant.compact => _buildCompact(context),
      MagnitudeTextVariant.display => _buildDisplay(context),
    };
  }

  Widget _buildCompact(BuildContext context) {
    final theme = Theme.of(context);
    // iOS ウィジェットの MagnitudeText と同じ比率に揃える
    const valueFontSize = 20.0;
    const label = TextSpan(
      text: 'M',
      style: TextStyle(
        fontFamily: FontFamily.googleSansFlex,
        fontSize: valueFontSize * 0.44,
        fontWeight: .w500,
        fontVariations: [
          FontVariation.opticalSize(valueFontSize * 0.44),
          FontVariation.weight(500),
        ],
        letterSpacing: 0,
      ),
    );
    const valueStyle = TextStyle(
      fontFamily: FontFamily.googleSansCode,
      fontSize: valueFontSize,
      fontWeight: .bold,
      fontVariations: [FontVariation.weight(700)],
      letterSpacing: 0,
    );
    // 等幅フォントの小数点は 1 文字分の幅を取るため、前後だけ詰める
    final kernedValueStyle = valueStyle.copyWith(
      letterSpacing: valueFontSize * -0.14,
    );
    const wordStyle = TextStyle(
      fontFamily: FontFamily.googleSansFlex,
      fontFamilyFallback: [FontFamily.notoSansJP],
      fontSize: valueFontSize * 0.74,
      fontWeight: .bold,
      fontVariations: [
        FontVariation.opticalSize(valueFontSize * 0.74),
        FontVariation.weight(700),
      ],
      letterSpacing: 0,
    );
    return Text.rich(
      TextSpan(
        children: switch (magnitude) {
          EarthquakeMagnitudeValue(:final value) => [
            label,
            ...switch (value.toStringAsFixed(1).split('.')) {
              [final integer, final fraction] => [
                TextSpan(text: integer, style: kernedValueStyle),
                TextSpan(text: '.', style: kernedValueStyle),
                TextSpan(text: fraction, style: valueStyle),
              ],
              final parts => [
                TextSpan(text: parts.join('.'), style: valueStyle),
              ],
            },
          ],
          EarthquakeMagnitudeUnknown() => [
            label,
            const TextSpan(text: '不明', style: wordStyle),
          ],
          EarthquakeMagnitudeOverM8() => [
            label,
            const TextSpan(text: '8超', style: wordStyle),
          ],
          null => [],
        },
        style: theme.textTheme.labelLarge?.copyWith(
          color: color,
          fontFamily: FontFamily.googleSansCode,
        ),
      ),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final (text, showM) = switch (magnitude) {
      EarthquakeMagnitudeValue(:final value) => (
        value.toStringAsFixed(1),
        true,
      ),
      EarthquakeMagnitudeUnknown() => ('不明', false),
      EarthquakeMagnitudeOverM8() => ('8+', true),
      null => ('調査中', false),
    };

    return Text.rich(
      TextSpan(
        children: [
          if (showM)
            TextSpan(
              text: 'M',
              style: textTheme.labelStyle(textTheme.titleSmall),
            ),
          TextSpan(
            text: text,
            style: textTheme.valueStyle(textTheme.headlineLarge),
          ),
        ],
      ),
    );
  }
}
