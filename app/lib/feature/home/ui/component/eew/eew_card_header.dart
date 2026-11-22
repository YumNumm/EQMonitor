import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:material_ui/material_ui.dart';

class const EewCardHeader({
  required final EewTelegramItem eew,
  required final bool isWarning,
  required final JmaIntensity maxIntensity,
}) extends StatelessWidget {
  static const _warningColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastColor = Color.fromRGBO(204, 102, 13, 1);
  static const _canceledColor = Color.fromRGBO(102, 102, 102, 1);
  static const _warningStripeColors = [
    Color.fromRGBO(255, 59, 48, 1),
    Colors.black,
  ];
  static const _forecastStripeColors = [
    Color.fromRGBO(255, 149, 0, 1),
    Color.fromRGBO(128, 64, 0, 1),
  ];
  static const _canceledStripeColors = [
    Color.fromRGBO(128, 128, 128, 1),
    Color.fromRGBO(64, 64, 64, 1),
  ];
  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final typeLabel = eew.isCanceled
        ? '緊急地震速報(取消)'
        : isWarning
        ? '緊急地震速報(警報)'
        : '緊急地震速報(予報)';
    final serialLabel = eew.isLastInfo
        ? '最終 第${eew.serialNo}報'
        : '第${eew.serialNo}報';
    final headline = eew.headline;
    final hypocenterName = eew.hypocenter?.name;
    final String? headlineText = eew.isCanceled
        ? null
        : (headline != null && headline.isNotEmpty)
        ? headline.replaceAll('　', ' ')
        : hypocenterName != null
        ? '$hypocenterNameで地震発生'
        : '地震発生';

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        designSystem.shape.card - spacing.md,
      ),
      child: ColoredBox(
        color: eew.isCanceled
            ? _canceledColor
            : isWarning
            ? _warningColor
            : _forecastColor,
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            WarningStripeDecoration(
              height: 5,
              colors: eew.isCanceled
                  ? _canceledStripeColors
                  : isWarning
                  ? _warningStripeColors
                  : _forecastStripeColors,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.md,
                vertical: spacing.sm,
              ),
              child: Row(
                spacing: spacing.sm,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text(
                          '$typeLabel $serialLabel',
                          style: EewCardFlexTextStyle(
                            size: 11,
                            weight: .w600,
                            color: _secondaryTextColor,
                          ),
                        ),
                        if (headlineText != null)
                          Text(
                            headlineText,
                            style: EewCardFlexTextStyle(
                              size: 15,
                              weight: .w800,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!eew.isCanceled)
                    _EewMaxIntensityLabel(intensity: maxIntensity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 現在地の色付きバッジと混同させないため、全国の最大震度は塗らずに `MAX` を添える。
class const _EewMaxIntensityLabel({required final JmaIntensity intensity})
    extends StatelessWidget {
  static const _size = 32.0;

  @override
  Widget build(BuildContext context) {
    final numberStyle = EewCardCodeTextStyle(
      size: _size,
      weight: .w800,
      color: Colors.white,
    );
    final maxLabel = Text(
      'MAX',
      style: EewCardCodeTextStyle(
        size: _size * 0.28,
        weight: .w800,
        color: Colors.white,
      ),
    );
    final suffix = intensity.suffix;

    return Semantics(
      label: intensity == JmaIntensity.unknown
          ? '最大予想震度 未発表'
          : '最大予想震度 ${intensity.label}',
      excludeSemantics: true,
      child: suffix.isEmpty
          // 数字の行は高さ40pt。MAXを上へ積むぶんはヘッダーの上下の余白へ逃がし、ヘッダーの高さを変えない。
          ? Align(
              heightFactor: 1.25 / (0.28 * 1.25 + 1.25 - 0.12),
              child: Column(
                mainAxisSize: .min,
                children: [
                  maxLabel,
                  Align(
                    alignment: .bottomCenter,
                    heightFactor: 1 - 0.12 / 1.25,
                    child: Text(intensity.mainText, style: numberStyle),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisSize: .min,
              crossAxisAlignment: .end,
              children: [
                Text(intensity.mainText, style: numberStyle),
                Padding(
                  padding: const EdgeInsets.only(bottom: _size * 0.12),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      maxLabel,
                      Text(
                        suffix,
                        style: EewCardFlexTextStyle(
                          size: _size * 0.45,
                          weight: .w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
