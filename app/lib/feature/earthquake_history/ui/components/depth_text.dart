import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_info_text_style.dart';
import 'package:flutter/material.dart';

/// 深さを表示する Widget。
///
/// `深さ`ラベルと値を分けて大きく見せる表示。詳細カードなどの強調用途。
class DepthText extends StatelessWidget {
  const DepthText({required this.depth, super.key});

  final EarthquakeDepth? depth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final (text, trailing, isSpecial) = switch (depth) {
      EarthquakeDepthShallow() => ('ごく浅い', null, true),
      EarthquakeDepthValue(:final value) => ('$value', 'km', false),
      EarthquakeDepthOver700km() => ('700', 'km以上', true),
      EarthquakeDepthUnknown() || null => ('調査中', null, true),
    };

    final subTextStyle = textTheme.labelStyle(textTheme.titleSmall!);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '深さ',
            style: subTextStyle,
          ),
          TextSpan(
            text: text,
            style: textTheme.valueStyle(
              isSpecial ? textTheme.headlineMedium! : textTheme.headlineLarge!,
            ),
          ),
          if (trailing != null)
            TextSpan(
              text: trailing,
              style: subTextStyle,
            ),
        ],
      ),
    );
  }
}
