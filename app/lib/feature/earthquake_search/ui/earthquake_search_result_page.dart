import 'dart:async';

import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_result.dart';
import 'package:eqmonitor/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EarthquakeSearchResultPage extends HookConsumerWidget {
  const EarthquakeSearchResultPage({
    required this.type,
    required this.code,
    required this.name,
    super.key,
  });

  final EarthquakeSearchType type;
  final String code;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(
      EarthquakeSearchParameter(
        type: type,
        code: code,
        name: name,
      ),
    );
    final state = ref.watch(earthquakeSearchProvider(parameter.value));

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then((_) async {
          final items = state.value?.items;
          if (items != null && items.length <= 10) {
            await ref
                .read(earthquakeSearchProvider(parameter.value).notifier)
                .fetchNextData();
          }
        }),
      );
      return null;
    }, [parameter.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text('$name の地震履歴'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _SearchParameter(
            parameter: parameter.value,
            onChanged: (value) => parameter.value = value,
          ),
        ),
      ),
      body: _SliverListBody(
        state: state,
        parameter: parameter.value,
        onRefresh: () async => ref
            .read(earthquakeSearchProvider(parameter.value).notifier)
            .refresh(),
        onScrollEnd: () async => ref
            .read(earthquakeSearchProvider(parameter.value).notifier)
            .fetchNextData(),
      ),
    );
  }
}

class _SearchParameter extends StatelessWidget {
  const _SearchParameter({
    required this.parameter,
    required this.onChanged,
  });

  final EarthquakeSearchParameter parameter;
  final ValueChanged<EarthquakeSearchParameter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IntensityFilterChip(
            min: parameter.intensityGte,
            max: parameter.intensityLte,
            onChanged: (min, max) =>
                onChanged(parameter.updateIntensity(min, max)),
          ),
          const SizedBox(width: 4),
          MagnitudeFilterChip(
            min: parameter.magnitudeGte,
            max: parameter.magnitudeLte,
            onChanged: (min, max) =>
                onChanged(parameter.updateMagnitude(min, max)),
          ),
          const SizedBox(width: 4),
          DepthFilterChip(
            min: parameter.depthGte,
            max: parameter.depthLte,
            onChanged: (min, max) => onChanged(parameter.updateDepth(min, max)),
          ),
          const SizedBox(width: 4),
          StatusFilterChip(
            statuses: parameter.statuses,
            onChanged: (statuses) =>
                onChanged(parameter.updateStatuses(statuses)),
          ),
        ],
      ),
    );
  }
}

class _SliverListBody extends HookConsumerWidget {
  const _SliverListBody({
    required this.state,
    required this.parameter,
    required this.onRefresh,
    required this.onScrollEnd,
  });

  final AsyncValue<EarthquakeSearchNotifierState> state;
  final EarthquakeSearchParameter parameter;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onScrollEnd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();

    useEffect(() {
      void listener() {
        if (controller.position.pixels >=
            controller.position.maxScrollExtent - 200) {
          unawaited(onScrollEnd?.call());
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    Widget listView({
      required List<EarthquakeSearchResultItem> items,
      required bool hasNext,
      Widget? loading,
    }) {
      final loadingWidget =
          loading ?? const _EarthquakeSearchSkeleton(itemCount: 2);
      if (items.isEmpty) {
        return const EarthquakeHistoryNotFound();
      }
      return ListView.separated(
        controller: controller,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        itemCount: items.length + 1,
        separatorBuilder: (context, index) =>
            const Divider(height: 0, indent: 0, endIndent: 0, thickness: 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            if (state.isLoading) {
              return loadingWidget;
            }
            if (state.hasError) {
              final error = state.error!;
              return ErrorCard(
                error: error,
                onReload: () async => onRefresh?.call(),
              );
            }
            if (hasNext) {
              return loadingWidget;
            } else {
              return const EarthquakeHistoryAllFetched();
            }
          }
          final item = items[index];
          return _EarthquakeSearchResultListTile(
            item: item,
            onTap: () async => EarthquakeHistoryDetailsRoute(
              eventId: item.earthquakePartial.eventId,
            ).push<void>(context),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: switch (state) {
        AsyncError(:final error) => () {
          final valueOrNull = state.value;
          if (valueOrNull != null) {
            return listView(
              items: valueOrNull.items,
              hasNext: valueOrNull.hasNext,
            );
          }
          return ErrorCard(
            error: error,
            onReload: () async =>
                ref.refresh(earthquakeSearchProvider(parameter)),
          );
        }(),
        AsyncData(:final value) => listView(
          items: value.items,
          hasNext: value.hasNext,
        ),
        _ => const _EarthquakeSearchSkeleton(),
      },
    );
  }
}

class _EarthquakeSearchSkeleton extends StatelessWidget {
  const _EarthquakeSearchSkeleton({this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final i in List.generate(itemCount, (i) => i))
            ListTile(
              leading: const CircleAvatar(radius: 20),
              title: Text('震源地 $i'),
              subtitle: const Text('2026/04/21 12:34頃発生\n最大震度 4'),
              trailing: const Text('M5.5'),
            ),
        ],
      ),
    );
  }
}

class _EarthquakeSearchResultListTile extends HookConsumerWidget {
  const _EarthquakeSearchResultListTile({
    required this.item,
    this.onTap,
  });

  final EarthquakeSearchResultItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final earthquake = item.earthquakePartial;
    final hypocenter = earthquake.hypocenter;
    final localIntensity = item.localIntensity;

    final hypoName = hypocenter?.name;
    final hypoDetailName = hypocenter?.detailedName;

    final title = switch ((hypoName, hypoDetailName)) {
      (final String hypoName, final String hypoDetailName) =>
        '$hypoName($hypoDetailName)',
      (final String hypoName, _) => hypoName,
      _ => '震源情報なし',
    };

    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final dateText = switch ((earthquake.originTime, earthquake.arrivalTime)) {
      (final DateTime originTime, _) =>
        '${dateFormatter.format(originTime.toLocal())}頃発生',
      (_, final DateTime arrivalTime) =>
        '${dateFormatter.format(arrivalTime.toLocal())}頃検知',
      _ => '',
    };

    final maxIntensity = earthquake.intensity?.maxIntensity;
    final maxIntensityText = maxIntensity != null
        ? '最大震度 ${maxIntensity.label}'
        : null;

    final subTitle = [
      dateText,
      maxIntensityText,
    ].where((e) => e != null && e.isNotEmpty).join('\n');

    final intensityColorState = ref.watch(intensityColorProvider);
    final intensityColor = localIntensity != null
        ? intensityColorState.fromJmaIntensity(localIntensity).background
        : null;

    final magnitudeText = _formatMagnitude(hypocenter?.magnitude);

    return ListTile(
      tileColor: intensityColor?.withValues(alpha: 0.4),
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: .bold,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontFamily: FontFamily.notoSansMono,
          fontFamilyFallback: [FontFamily.notoSansJP],
          letterSpacing: -0.2,
        ),
      ),
      leading: localIntensity != null
          ? JmaIntensityIcon(
              intensity: localIntensity,
              type: .filled,
              size: 40,
            )
          : null,
      trailing: _MagnitudeText(
        text: magnitudeText,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: .bold,
          fontFamily: FontFamily.notoSansMono,
        ),
      ),
    );
  }

  String _formatMagnitude(EarthquakeMagnitude? magnitude) {
    if (magnitude == null) {
      return '';
    }
    return switch (magnitude) {
      EarthquakeMagnitudeValue(:final value) => 'M${value.toStringAsFixed(1)}',
      EarthquakeMagnitudeUnknown() => 'M不明',
      EarthquakeMagnitudeOverM8() => 'M8を超える巨大地震',
    };
  }
}

class _MagnitudeText extends StatelessWidget {
  const _MagnitudeText({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    // ドット部分の間隔を狭くするためにRichTextを使用
    final dotIndex = text.indexOf('.');
    if (dotIndex == -1) {
      return Text(text, style: style);
    }

    final beforeDot = text.substring(0, dotIndex);
    final afterDot = text.substring(dotIndex + 1);

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: beforeDot),
          TextSpan(
            text: '.',
            style: style.copyWith(letterSpacing: -2),
          ),
          TextSpan(text: afterDot),
        ],
      ),
    );
  }
}
