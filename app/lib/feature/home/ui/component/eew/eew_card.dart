import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_colors.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_header.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_local_forecast_section.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_source_section.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
import 'package:material_ui/material_ui.dart';

class const EewCard({
  required final EewTelegramItem eew,
  required final String? index,

  /// シミュレーション再生など、現在時刻の代わりに使う時刻。0.1秒の表示を進めるため描画のたびに呼ぶ。
  final DateTime Function()? clockOverride,

  /// 距離減衰式による推計震度。JMAが現在地の予想震度を発表していない場合の
  /// フォールバックとして利用する。
  final List<EewEstimatedRegion>? estimatedRegions,

  /// 過去のEEWを再生する画面では、現在地への警報と誤解させないため無効にする。
  final bool emphasizesLocalWarning = true,
  super.key,
}) extends ConsumerWidget {
  static const _localWarningSurfaceColor = Color.fromRGBO(51, 0, 0, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWarning = eew.isWarning ?? false;

    // 取消報は発生時刻を持たないが、取消の旨を表示するためカードは描画する。
    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null && !eew.isCanceled) {
      return const SizedBox.shrink();
    }

    final positionAsync = ref.watch(locationStreamProvider);
    final position = positionAsync.value;
    final regionItem = position != null
        ? ref
              .watch(
                jmaMapAreaForecastLocalEInsideProvider(
                  lat_lng.LatLng(position.latitude, position.longitude),
                ),
              )
              .value
        : null;

    final regionCode = regionItem?.property?.code;
    final regionDisplayName = regionItem?.property?.name;

    EewForecastRegionInfo? localForecastRegion(
      EewTelegramItem eew,
      String? regionCode,
    ) {
      if (regionCode == null) {
        return null;
      }
      final regions = eew.forecastIntensity?.regions;
      if (regions == null || regions.isEmpty) {
        return null;
      }
      return regions.firstWhereOrNull((r) => r.code == regionCode);
    }

    final localRegion = localForecastRegion(eew, regionCode);

    // JMAのlocalRegionがない場合、推定値をフォールバック
    final estimate = regionCode != null
        ? estimatedRegions?.firstWhereOrNull((e) => e.regionCode == regionCode)
        : null;
    final effectiveLocalIntensity =
        localRegion?.intensity ?? estimate?.jmaIntensity;
    final effectiveRegionName = regionDisplayName ?? estimate?.regionName;

    // PLUM法は到達時刻が発表されない。報全体がPLUM法なら現在地の予想もPLUM法による。
    final isLocalPlum = eew.isPlum || (localRegion?.isPlum ?? false);
    final hideArrival = eew.isCanceled || isLocalPlum;

    // 到達時間: JMA値を優先、なければ推定値
    final effectiveArrivalTime = hideArrival
        ? null
        : (localRegion?.arrivalTime ?? estimate?.sWaveArrivalTime);
    final effectiveIsArrived = hideArrival
        ? false
        : (localRegion?.isArrived ?? estimate?.isArrived ?? false);

    // 推計値は警報対象かどうかを持たないため、JMAの発表値だけで判定する。
    final isLocalWarning =
        emphasizesLocalWarning &&
        !eew.isCanceled &&
        isWarning &&
        (localRegion?.isWarning ?? false);

    final colorTheme = context.designSystem.colorTheme;
    final usesDarkSurface =
        isLocalWarning || Theme.of(context).brightness == Brightness.dark;
    final colors = usesDarkSurface
        ? EewCardColors(
            surface: isLocalWarning ? _localWarningSurfaceColor : Colors.black,
            border: isLocalWarning
                ? _localWarningSurfaceColor
                : colorTheme.outlineVariant,
            primary: Colors.white,
            secondary: Colors.white.withValues(alpha: 0.8),
            divider: Colors.white.withValues(alpha: 0.35),
            watermark: Colors.white.withValues(alpha: 0.2),
          )
        : EewCardColors(
            surface: colorTheme.surfaceContainer,
            border: colorTheme.outlineVariant,
            primary: colorTheme.onSurface,
            secondary: colorTheme.onSurfaceVariant,
            divider: colorTheme.outline,
            watermark: colorTheme.onSurfaceVariant.withValues(alpha: 0.2),
          );

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index case final index?)
          Positioned.fill(
            child: _WatermarkText(text: index, color: colors.watermark),
          ),
        _EewMainCard(
          eew: eew,
          colors: colors,
          isWarning: isWarning,
          isLocalWarning: isLocalWarning,
          happenedTime: happenedTime,
          localForecastIntensity: effectiveLocalIntensity,
          regionDisplayName: effectiveRegionName,
          arrivalTime: effectiveArrivalTime,
          isArrived: effectiveIsArrived,
          isImminentArrival: !eew.isCanceled && isLocalPlum,
          clockOverride: clockOverride,
          showDeepHypocenterIntensityNotice: ref
              .watch(eewDeepHypocenterIntensityNoticeProvider)
              .shouldShow(eew: eew),
        ),
        if (eew.status != TelegramStatus.normal)
          Positioned.fill(
            child: _WatermarkText(
              text: eew.status.name,
              color: colors.watermark,
            ),
          ),
      ],
    );
  }
}

class const _EewMainCard({
  required final EewTelegramItem eew,
  required final EewCardColors colors,
  required final bool isWarning,
  required final bool isLocalWarning,
  required final DateTime? happenedTime,
  required final JmaIntensity? localForecastIntensity,
  required final String? regionDisplayName,
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final bool isImminentArrival,
  required final DateTime Function()? clockOverride,
  required final bool showDeepHypocenterIntensityNotice,
}) extends StatelessWidget {
  static const _deepHypocenterIntensityNotice =
      '震源の深さが150kmより深いため、予想震度は発表されていません';
  static const _deepHypocenterIntensityNoticeLines =
      '震源の深さが150kmより深いため、\n予想震度は発表されていません';

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final forecastIntensity = eew.forecastIntensity;
    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;
    final happenedTime = this.happenedTime;
    final regionDisplayName = this.regionDisplayName;
    final localForecastIntensity = this.localForecastIntensity;
    final showsLocalForecast =
        regionDisplayName != null &&
        regionDisplayName.isNotEmpty &&
        localForecastIntensity != null;
    final deepNotice = Text(
      _deepHypocenterIntensityNoticeLines,
      semanticsLabel: _deepHypocenterIntensityNotice,
      style: EewCardFlexTextStyle(
        size: 11,
        weight: .w500,
        color: colors.secondary,
      ),
    );

    return Card(
      elevation: 0,
      clipBehavior: .antiAlias,
      margin: EdgeInsets.zero,
      color: colors.surface,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: colors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            EewCardHeader(
              eew: eew,
              isWarning: isWarning,
              maxIntensity:
                  forecastIntensity?.maxIntensity ?? JmaIntensity.unknown,
            ),
            SizedBox(height: showsLocalForecast ? 6 : spacing.sm),
            if (eew.isCanceled)
              Text(
                '緊急地震速報は取り消されました',
                style: EewCardFlexTextStyle(
                  size: 15,
                  weight: .w800,
                  color: colors.primary,
                ),
              )
            else if (happenedTime != null) ...[
              LayoutBuilder(
                builder: (context, constraints) => Row(
                  crossAxisAlignment: .end,
                  spacing: spacing.sm,
                  children: [
                    Expanded(
                      child: EewCardSourceSection(
                        eew: eew,
                        happenedTime: happenedTime,
                        colors: colors,
                        isLocalWarning: isLocalWarning,
                        isCompact:
                            isLocalWarning || showDeepHypocenterIntensityNotice,
                      ),
                    ),
                    if (showsLocalForecast)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.6,
                        ),
                        child: EewCardLocalForecastSection(
                          intensity: localForecastIntensity,
                          regionDisplayName: regionDisplayName,
                          isLocalWarning: isLocalWarning,
                          arrivalTime: arrivalTime,
                          isArrived: isArrived,
                          isImminentArrival: isImminentArrival,
                          clockOverride: clockOverride,
                          colors: colors,
                        ),
                      )
                    else if (showDeepHypocenterIntensityNotice)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.6,
                        ),
                        child: deepNotice,
                      ),
                  ],
                ),
              ),
              if (showsLocalForecast && showDeepHypocenterIntensityNotice)
                Padding(
                  padding: EdgeInsets.only(top: spacing.sm),
                  child: deepNotice,
                ),
              if (maxLpgmIntensity != null &&
                  maxLpgmIntensity != JmaLpgmIntensity.zero)
                Padding(
                  padding: EdgeInsets.only(top: spacing.sm),
                  child: _EewLpgmSection(
                    intensity: maxLpgmIntensity,
                    colors: colors,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class const _EewLpgmSection({
  required final JmaLpgmIntensity intensity,
  required final EewCardColors colors,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '予想最大長周期地震動階級 ${intensity.label}',
          style: EewCardFlexTextStyle(
            size: 15,
            weight: .w700,
            color: colors.primary,
          ),
        ),
        Text(
          '高層階では特に周期の長い揺れに注意してください',
          style: EewCardFlexTextStyle(
            size: 11,
            weight: .w500,
            color: colors.secondary,
          ),
        ),
      ],
    );
  }
}

class const _WatermarkText({
  required final String text,
  required final Color color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 100,
            fontWeight: .w700,
            fontFamily: codeFontFamily,
            letterSpacing: -0.5,
            color: color,
          ),
        ),
      ),
    );
  }
}
