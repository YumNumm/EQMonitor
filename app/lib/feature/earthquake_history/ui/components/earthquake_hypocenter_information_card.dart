import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/extension/earthquake_v1.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/util/event_id.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// 地震情報カード
///
/// 地震情報をカード形式で表示するウィジェット
class EarthquakeHypocenterInformationCard extends HookConsumerWidget {
  const EarthquakeHypocenterInformationCard({required this.item, super.key});

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 地震情報の取得
    final earthquakeInfo = _useEarthquakeInfo(item, ref);

    // 最大震度アイコン
    final maxIntensityWidget =
        earthquakeInfo.isFarEarthquake
            ? _FarEarthquakeHeaderIcon(isVolcano: earthquakeInfo.isVolcano)
            : earthquakeInfo.maxIntensity != null
            ? _MaxIntensityWidget(intensity: earthquakeInfo.maxIntensity!)
            : null;

    // 地震情報本体
    final body = _EarthquakeInformationBody(item: item, info: earthquakeInfo);

    final cardBackgroundColor =
        earthquakeInfo.colorScheme?.background ?? Colors.transparent;

    final cardColor = cardBackgroundColor.withValues(alpha: 0.3);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ).add(const EdgeInsets.only(bottom: 4)),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBackgroundColor, width: 0),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                if (maxIntensityWidget != null) maxIntensityWidget,
                const SizedBox(width: 4),
                Expanded(child: body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 地震情報モデル
/// コードの可読性向上のため、地震情報を整理するデータクラス
class _EarthquakeInfo {
  const _EarthquakeInfo({
    required this.isVolcano,
    required this.isFarEarthquake,
    required this.maxIntensity,
    required this.colorScheme,
    required this.isMagnitudeAndDepthUnknown,
    required this.isEarthquakeNull,
    required this.epicenterName,
    required this.epicenterDetailName,
  });

  final bool isVolcano;
  final bool isFarEarthquake;
  final JmaIntensity? maxIntensity;
  final TextColorModel? colorScheme;
  final bool isMagnitudeAndDepthUnknown;
  final bool isEarthquakeNull;
  final String? epicenterName;
  final String? epicenterDetailName;
}

/// 地震情報を取得するフック
_EarthquakeInfo _useEarthquakeInfo(EarthquakeV1Extended item, WidgetRef ref) {
  final intensityColorScheme = ref.watch(intensityColorProvider);
  final isVolcano = item.isVolcano;
  final isFarEarthquake = item.headline?.contains('海外で規模の大きな地震') ?? false;
  final maxIntensity = item.maxIntensity;

  // 震度に応じた色スキーム
  final colorScheme = switch (maxIntensity) {
    final JmaIntensity intensity => intensityColorScheme.fromJmaIntensity(
      intensity,
    ),
    _ when isVolcano => intensityColorScheme.sixUpper,
    _ => null,
  };

  // 震源地情報の取得
  final codeTable = ref.watch(jmaCodeTableProvider);
  final hypoNameItem = useMemoized(
    () => codeTable.areaEpicenter.items.firstWhereOrNull(
      (e) => int.tryParse(e.code) == item.epicenterCode,
    ),
    [item.epicenterCode],
  );

  final hypoDetailNameItem = useMemoized(
    () => codeTable.areaEpicenterDetail.items.firstWhereOrNull(
      (e) => int.tryParse(e.code) == item.epicenterDetailCode,
    ),
    [item.epicenterDetailCode],
  );

  // 震源地の名前
  final epicenterName = hypoNameItem?.name;
  final epicenterDetailName = hypoDetailNameItem?.name;

  // マグニチュードと深さが不明かどうか
  final isMagnitudeAndDepthUnknown =
      (item.magnitudeCondition?.toHalfWidth == 'M不明' ||
          item.magnitude == null) &&
      item.depth == null;

  // 震源地、マグニチュード、深さがすべて不明かどうか
  final isEarthquakeNull =
      isMagnitudeAndDepthUnknown && item.epicenterCode == null;

  return _EarthquakeInfo(
    isVolcano: isVolcano,
    isFarEarthquake: isFarEarthquake,
    maxIntensity: maxIntensity,
    colorScheme: colorScheme,
    isMagnitudeAndDepthUnknown: isMagnitudeAndDepthUnknown,
    isEarthquakeNull: isEarthquakeNull,
    epicenterName: epicenterName,
    epicenterDetailName: epicenterDetailName,
  );
}

/// 最大震度アイコンウィジェット
class _MaxIntensityWidget extends StatelessWidget {
  const _MaxIntensityWidget({required this.intensity});

  final JmaIntensity intensity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        JmaIntensityIcon(
          type: IntensityIconType.filled,
          size: 60,
          intensity: intensity,
        ),
      ],
    );
  }
}

/// 火山の噴火ヘッダー
class _FarEarthquakeHeaderIcon extends StatelessWidget {
  const _FarEarthquakeHeaderIcon({required this.isVolcano});

  final bool isVolcano;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SizedBox(
      height: 60,
      width: 60,
      child: Card(
        elevation: 0,
        color: colorScheme.errorContainer,
        child: Icon(
          isVolcano ? Icons.volcano : Icons.public,
          size: 40,
          color: colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

/// 地震情報本体ウィジェット
class _EarthquakeInformationBody extends HookWidget {
  const _EarthquakeInformationBody({required this.item, required this.info});

  final EarthquakeV1Extended item;
  final _EarthquakeInfo info;

  @override
  Widget build(BuildContext context) {
    // 地震発生時刻
    final creationDateFromEventId = EventId(item.eventId).toCreationDate();
    final timeText = _getTimeText(
      item,
      info.isVolcano,
      creationDateFromEventId,
    );
    final timeWidget =
        timeText != null ? Wrap(children: [Text(timeText)]) : null;

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.center,
      children: [
        const Row(),

        // 火山情報
        if (info.isVolcano)
          _VolcanoInformationWidget(
            item: item,
            epicenterName: info.epicenterName,
            epicenterDetailName: info.epicenterDetailName,
          )
        // 地震情報がすべて不明な場合
        else if (info.isEarthquakeNull)
          _EarthquakeNullWidget(item: item)
        // マグニチュードと深さが不明な場合
        else if (info.isMagnitudeAndDepthUnknown) ...[
          _MagnitudeDepthUnknownWidget(item: item),
          _HypocenterWidget(
            epicenterName: info.epicenterName,
            epicenterDetailName: info.epicenterDetailName,
          ),
        ]
        // 通常の地震情報
        else ...[
          _MagnitudeWidget(item: item),
          _DepthWidget(item: item, isFarEarthquake: info.isFarEarthquake),
          const SizedBox(width: double.infinity),
          _HypocenterWidget(
            epicenterName: info.epicenterName,
            epicenterDetailName: info.epicenterDetailName,
          ),
        ],

        const Row(),
        if (timeWidget != null) timeWidget,
      ],
    );
  }

  // 地震発生時刻のテキストを取得
  String? _getTimeText(
    EarthquakeV1Extended item,
    bool isVolcano,
    DateTime? creationDateFromEventId,
  ) {
    if (creationDateFromEventId == null) {
      return null;
    }

    return switch ((
      item.originTime,
      item.arrivalTime,
      creationDateFromEventId,
    )) {
      (final DateTime originTime, _, _) when isVolcano =>
        "噴火時刻: ${DateFormat('yyyy/MM/dd HH:mm頃').format(originTime.toLocal())}",
      (final DateTime originTime, _, _) =>
        "発生時刻: ${DateFormat('yyyy/MM/dd HH:mm頃').format(originTime.toLocal())}",
      (_, final DateTime arrivalTime, _) =>
        "検知時刻: ${DateFormat('yyyy/MM/dd HH:mm頃').format(arrivalTime.toLocal())}",
      (_, _, final DateTime creationDateFromEventId) =>
        "時刻: ${DateFormat('yyyy/MM/dd HH:mm頃').format(creationDateFromEventId)}",
      _ => null,
    };
  }
}

/// 共通のスタイル関数
extension _TextStyleExtension on TextTheme {
  // ラベルスタイル (小さい文字でグレー)
  TextStyle labelStyle(TextStyle base) {
    return base.copyWith(
      color: base.color!.withValues(alpha: 0.8),
      fontWeight: FontWeight.bold,
    );
  }

  // 値スタイル (太字)
  TextStyle valueStyle(TextStyle base) {
    return base.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.notoSansJP,
    );
  }
}

/// 火山情報ウィジェット
class _VolcanoInformationWidget extends StatelessWidget {
  const _VolcanoInformationWidget({
    required this.item,
    required this.epicenterName,
    required this.epicenterDetailName,
  });

  final EarthquakeV1Extended item;
  final String? epicenterName;
  final String? epicenterDetailName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final volcanoName = item.volcanoName;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '火山の大規模な噴火',
                style: textTheme.labelStyle(textTheme.titleSmall!),
              ),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: volcanoName ?? '不明',
                style: textTheme.valueStyle(textTheme.headlineSmall!),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: epicenterName ?? '不明',
                  style: textTheme.titleMedium,
                ),
                if (epicenterDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '($epicenterDetailName)',
                    style: textTheme.titleSmall,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 震源地ウィジェット
class _HypocenterWidget extends StatelessWidget {
  const _HypocenterWidget({
    required this.epicenterName,
    required this.epicenterDetailName,
  });

  final String? epicenterName;
  final String? epicenterDetailName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text('震源地', style: textTheme.labelStyle(textTheme.bodySmall!)),
        const SizedBox(width: 4),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: epicenterName ?? '不明',
                  style: textTheme.valueStyle(textTheme.headlineSmall!),
                ),
                if (epicenterDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '\n($epicenterDetailName)',
                    style: textTheme.valueStyle(textTheme.titleMedium!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// マグニチュードウィジェット
class _MagnitudeWidget extends StatelessWidget {
  const _MagnitudeWidget({required this.item});

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (item.magnitudeCondition == null)
          Text('M', style: textTheme.labelStyle(textTheme.titleSmall!)),
        Flexible(
          child: Text(
            _getMagnitudeText(),
            style: _getMagnitudeStyle(textTheme),
          ),
        ),
      ],
    );
  }

  String _getMagnitudeText() {
    return switch ((item.magnitudeCondition, item.magnitude)) {
      (final String cond, _) => cond.toHalfWidth,
      (_, final double value) => value.toStringAsFixed(1),
      // vxse53がある場合
      _ when item.intensityCities != null => '不明',
      _ => '調査中',
    };
  }

  TextStyle _getMagnitudeStyle(TextTheme textTheme) {
    final baseStyle =
        item.magnitudeCondition != null
            ? textTheme.headlineMedium!
            : textTheme.headlineLarge!;

    return textTheme.valueStyle(baseStyle);
  }
}

/// 深さウィジェット
class _DepthWidget extends StatelessWidget {
  const _DepthWidget({required this.item, required this.isFarEarthquake});

  final EarthquakeV1Extended item;
  final bool isFarEarthquake;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // 遠地地震で深さが不明な場合は表示しない
    if (isFarEarthquake && item.depth == null) {
      return const SizedBox.shrink();
    }
    String getDepthText() {
      return switch (item.depth) {
        0 => 'ごく浅い',
        700 => '700km以上',
        // vxse53がある場合
        _ when item.intensityCities != null => '不明',
        _ => '調査中',
      };
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('深さ', style: textTheme.labelStyle(textTheme.titleSmall!)),
        if (item.depth != null) ...[
          Text(
            item.depth.toString(),
            style: textTheme.valueStyle(textTheme.headlineLarge!),
          ),
          Text('km', style: textTheme.labelStyle(textTheme.titleMedium!)),
        ] else
          Text(
            getDepthText(),
            style: textTheme.valueStyle(textTheme.headlineMedium!),
          ),
      ],
    );
  }
}

/// マグニチュード・深さ不明ウィジェット
class _MagnitudeDepthUnknownWidget extends StatelessWidget {
  const _MagnitudeDepthUnknownWidget({required this.item});

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    return _UnknownInfoWidget(label: 'M・深さ', value: _getValue(), item: item);
  }

  String _getValue() {
    return item.intensityCities != null ? '不明' : '調査中';
  }
}

/// 地震情報すべて不明ウィジェット
class _EarthquakeNullWidget extends StatelessWidget {
  const _EarthquakeNullWidget({required this.item});

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    return _UnknownInfoWidget(
      label: 'M・深さ・震源地',
      value: item.intensityCities != null ? '不明' : '調査中',
      item: item,
    );
  }
}

/// 不明情報共通ウィジェット
class _UnknownInfoWidget extends StatelessWidget {
  const _UnknownInfoWidget({
    required this.label,
    required this.value,
    required this.item,
  });

  final String label;
  final String value;
  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(label, style: textTheme.labelStyle(textTheme.titleMedium!)),
        const SizedBox(width: 4),
        Text(
          value,
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
  }
}
