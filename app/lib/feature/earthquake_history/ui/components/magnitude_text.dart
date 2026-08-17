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
class MagnitudeText extends StatelessWidget {
  const new({
    required this.magnitude,
    this.variant = MagnitudeTextVariant.compact,
    this.color,
    super.key,
  });

  final EarthquakeMagnitude? magnitude;
  final MagnitudeTextVariant variant;

  /// 文字色の上書き。[MagnitudeTextVariant.compact] でのみ有効。
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      MagnitudeTextVariant.compact => _buildCompact(context),
      MagnitudeTextVariant.display => _buildDisplay(context),
    };
  }

  Widget _buildCompact(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        children: switch (magnitude) {
          EarthquakeMagnitudeValue(:final value) => [
            const TextSpan(
              text: 'M',
              style: TextStyle(
                fontFamily: FontFamily.googleSansCode,
                letterSpacing: 1,
              ),
            ),
            TextSpan(
              text: value.toStringAsFixed(1),
              style: const TextStyle(
                fontFamily: FontFamily.googleSansCode,
                letterSpacing: -1,
              ),
            ),
          ],
          EarthquakeMagnitudeUnknown() => [const TextSpan(text: 'M不明')],
          EarthquakeMagnitudeOverM8() => [const TextSpan(text: 'M8超')],
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
      EarthquakeMagnitudeOverM8() => ('8超', true),
      null => ('調査中', false),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (showM) Text('M', style: textTheme.labelStyle(textTheme.titleSmall)),
        Flexible(
          child: Text(
            text,
            style: textTheme.valueStyle(
              showM ? textTheme.headlineLarge : textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
