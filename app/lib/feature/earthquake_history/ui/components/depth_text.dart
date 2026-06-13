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

    final (text, isSpecial) = switch (depth) {
      EarthquakeDepthShallow() => ('ごく浅い', true),
      EarthquakeDepthValue(:final value) => ('${value}km', false),
      EarthquakeDepthOver700km() => ('700km以上', true),
      EarthquakeDepthUnknown() || null => ('調査中', true),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('深さ', style: textTheme.labelStyle(textTheme.titleSmall!)),
        Text(
          text,
          style: textTheme.valueStyle(
            isSpecial ? textTheme.headlineMedium! : textTheme.headlineLarge!,
          ),
        ),
      ],
    );
  }
}
