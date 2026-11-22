import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_colors.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class const EewCardSourceSection({
  required final EewTelegramItem eew,
  required final DateTime happenedTime,
  required final EewCardColors colors,
  required final bool isLocalWarning,
  required final bool isCompact,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: isLocalWarning ? 2 : context.designSystem.spacing.xs,
      children: [
        _EewEventTime(
          eew: eew,
          happenedTime: happenedTime,
          color: colors.secondary,
        ),
        if (isLocalWarning) const _EewLocalWarningNotice(),
        _EewSourceMetrics(eew: eew, colors: colors, isCompact: isCompact),
      ],
    );
  }
}

class const _EewEventTime({
  required final EewTelegramItem eew,
  required final DateTime happenedTime,
  required final Color color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = EewCardCodeTextStyle(size: 10, weight: .w500, color: color);
    final timeLabel =
        (eew.originTime == null || eew.isPlum || eew.isLevelMethod)
        ? '地震検知'
        : '地震発生';

    return Wrap(
      spacing: 12,
      children: [
        Text(timeLabel, style: style),
        Text(
          '${happenedTime.formatWithTz(.monthDay)} '
          '${happenedTime.formatWithTz(.hourMinuteSecond)}',
          style: style,
        ),
      ],
    );
  }
}

class const _EewLocalWarningNotice() extends HookWidget {
  static const _fillColor = Color.fromRGBO(184, 0, 0, 1);
  static const _blinkInterval = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final isFilled = useState(true);
    useEffect(() {
      if (disableAnimations) {
        isFilled.value = true;
        return null;
      }
      final timer = Timer.periodic(_blinkInterval, (_) {
        isFilled.value = !isFilled.value;
      });
      return timer.cancel;
      // isFilled はこのTimer自身がトグルする値。keysに入れると500msごとに
      // Timerが破棄・再生成され点滅が破綻するため、意図的に含めない。
      // ignore_keys: isFilled.value
    }, [disableAnimations]);

    return Semantics(
      label: '現在地は緊急地震速報の警報対象地域です',
      excludeSemantics: true,
      child: FittedBox(
        fit: .scaleDown,
        alignment: .centerLeft,
        child: ColoredBox(
          color: isFilled.value ? _fillColor : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              '強い揺れに警戒!',
              style: EewCardFlexTextStyle(
                size: 12,
                weight: .w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _EewSourceMetrics({
  required final EewTelegramItem eew,
  required final EewCardColors colors,
  required final bool isCompact,
}) extends StatelessWidget {
  static const _size = 28.0;
  static const _compactSize = 77.23 / 3;

  @override
  Widget build(BuildContext context) {
    final detectionMethodLabel = switch ((
      eew.isPlum,
      eew.isLevelMethod,
      eew.isOnePointDetection,
    )) {
      (true, _, _) => 'PLUM法',
      (_, true, _) => 'レベル法',
      (_, _, true) => '低精度',
      _ => null,
    };
    if (detectionMethodLabel != null) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.primary.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Text(
              detectionMethodLabel,
              style: EewCardFlexTextStyle(
                size: 12,
                weight: .w700,
                color: colors.primary,
              ).copyWith(height: 14 / 12),
            ),
          ),
        ),
      );
    }

    final size = isCompact ? _compactSize : _size;
    final depth = eew.hypocenter?.depth;
    final labelStyle = EewCardFlexTextStyle(
      size: size * 0.44,
      weight: .w500,
      color: colors.primary,
    );
    final valueStyle = EewCardCodeTextStyle(
      size: size,
      weight: .w700,
      color: colors.primary,
    );
    final magnitudeParts = eew.hypocenter?.magnitude
        ?.toStringAsFixed(1)
        .split('.');

    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            if (magnitudeParts != null) ...[
              TextSpan(text: 'M', style: labelStyle),
              // 等幅フォントの小数点は1文字分の幅を取るため、小数点の前後だけを詰める。
              TextSpan(
                text: '${magnitudeParts.first}.',
                style: valueStyle.copyWith(letterSpacing: size * -0.14),
              ),
              TextSpan(text: magnitudeParts.last, style: valueStyle),
            ],
            if (magnitudeParts != null && depth != null)
              TextSpan(
                text: '  ',
                style: EewCardFlexTextStyle(
                  size: 18,
                  weight: .w400,
                  color: colors.primary,
                ),
              ),
            if (depth != null) ...[
              TextSpan(text: '深さ ', style: labelStyle),
              if (depth == 0)
                TextSpan(
                  text: 'ごく浅い',
                  style: EewCardFlexTextStyle(
                    size: size,
                    weight: .w700,
                    color: colors.primary,
                  ),
                )
              else ...[
                TextSpan(text: '$depth', style: valueStyle),
                TextSpan(
                  text: depth == 700 ? 'km以上' : 'km',
                  style: labelStyle,
                ),
              ],
            ],
          ],
        ),
        maxLines: 1,
      ),
    );
  }
}
