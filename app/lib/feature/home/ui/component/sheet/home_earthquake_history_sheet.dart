import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:cue/cue.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const HomeEarthquakeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      data: (home) => Card.outlined(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: colorScheme.surfaceContainer,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: _ScopeSelector(
                scope: home.earthquakeHistoryScope,
                onScopeChanged: (scope) async => ref
                    .read(homeConfigurationProvider.notifier)
                    .setEarthquakeHistoryScope(scope),
              ),
            ),
            paramAsync.when(
              data: (param) {
                if (param == null) {
                  return _ScopeUnavailableBody(
                    scope: home.earthquakeHistoryScope,
                    onRetry: () => ref.invalidate(
                      homeEarthquakeHistoryParameterProvider,
                    ),
                  );
                }
                final state = ref.watch(earthquakeHistoryProvider(param));
                final listSection = switch (state) {
                  AsyncData(:final value) =>
                    value.items.isEmpty
                        ? const EarthquakeHistoryNotFound()
                        : _EarthquakeList(earthquakes: value.items),
                  AsyncError(:final error) => ErrorCard(
                    error: error,
                    margin: EdgeInsets.zero,
                    onReload: () async {
                      ref.invalidate(homeEarthquakeHistoryParameterProvider);
                      ref.invalidate(earthquakeHistoryProvider(param));
                    },
                    padding: const EdgeInsets.all(8),
                  ),
                  _ => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                };
                if (home.earthquakeHistoryScope ==
                    HomeEarthquakeHistoryScope.currentLocation) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _CurrentLocationSearchContextBanner(parameter: param),
                      listSection,
                    ],
                  );
                }
                return listSection;
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
              error: (error, _) => ErrorCard(
                error: error,
                margin: EdgeInsets.zero,
                onReload: () async =>
                    ref.invalidate(homeEarthquakeHistoryParameterProvider),
                padding: const EdgeInsets.all(8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async =>
                      const EarthquakeHistoryRoute().push<void>(context),
                  child: const Text('さらに表示'),
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => Card.outlined(
        color: colorScheme.surfaceContainer,
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

class _ScopeSelector extends StatelessWidget {
  const _ScopeSelector({
    required this.scope,
    required this.onScopeChanged,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: CueModalTransition(
        motion: const Spring.smooth(),
        reverseMotion: const Spring.snappy(),
        barrierColor: Colors.black.withValues(alpha: 0.14),
        hideTriggerOnTransition: true,
        alignment: Alignment.topLeft,
        backdrop: Actor(
          acts: const [
            Act.backdropBlur(
              to: 20,
              motion: Spring.gentle(),
            ),
          ],
          child: ColoredBox(
            color: colorScheme.scrim.withValues(alpha: 0.06),
          ),
        ),
        triggerBuilder: (context, showModal) {
          return _GlassScopeChip(
            scope: scope,
            onPressed: showModal,
          );
        },
        builder: (context, rect) {
          final panelWidth = math.max(232, rect.width).toDouble();

          return Actor(
            acts: [
              Act.sizedClip(
                from: NSize.size(rect.size),
                to: NSize(w: panelWidth),
                motion: const Spring.smooth(),
                alignment: Alignment.topLeft,
                clipGeometry: const ClipGeometry.superEllipse(
                  BorderRadius.all(Radius.circular(22)),
                ),
              ),
              const Act.fadeIn(motion: Spring.smooth()),
            ],
            child: _GlassScopePickerContent(
              scope: scope,
              onSelected: (next) {
                onScopeChanged(next);
                Navigator.of(context).pop<void>();
              },
            ),
          );
        },
      ),
    );
  }
}

String _scopeShortLabel(HomeEarthquakeHistoryScope scope) => switch (scope) {
  .nationwide => '全国',
  .currentLocation => '現在地',
  .designatedRegion => '指定地域',
};

class _GlassScopeChip extends StatelessWidget {
  const _GlassScopeChip({
    required this.scope,
    required this.onPressed,
  });

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.42),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface.withValues(alpha: 0.72),
                    colorScheme.surface.withValues(alpha: 0.38),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Cue.onChange(
                      value: scope,
                      motion: const Spring.snappy(),
                      fromCurrentValue: true,
                      acts: const [
                        Act.fadeIn(),
                        Act.slideY(from: 0.1),
                      ],
                      child: Text(
                        _scopeShortLabel(scope),
                        style: textStyle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.expand_more_rounded,
                      size: 22,
                      color: colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassScopePickerContent extends StatelessWidget {
  const _GlassScopePickerContent({
    required this.scope,
    required this.onSelected,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onSelected;

  static const List<HomeEarthquakeHistoryScope> _scopes = [
    HomeEarthquakeHistoryScope.nationwide,
    HomeEarthquakeHistoryScope.currentLocation,
    HomeEarthquakeHistoryScope.designatedRegion,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface.withValues(alpha: 0.85),
                colorScheme.surface.withValues(alpha: 0.55),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < _scopes.length; i++)
                  Actor(
                    delay: Duration(milliseconds: 28 * i),
                    acts: const [
                      Act.fadeIn(),
                      Act.slideY(from: 0.08),
                    ],
                    child: _GlassScopePickerTile(
                      label: _scopeShortLabel(_scopes[i]),
                      selected: _scopes[i] == scope,
                      onTap: () => onSelected(_scopes[i]),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassScopePickerTile extends StatelessWidget {
  const _GlassScopePickerTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(child: Text(label, style: titleStyle)),
              if (selected)
                Icon(
                  Icons.check_rounded,
                  size: 22,
                  color: colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentLocationSearchContextBanner extends StatelessWidget {
  const _CurrentLocationSearchContextBanner({required this.parameter});

  final EarthquakeHistoryParameter parameter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bodyStyle = theme.textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
      height: 1.4,
    );
    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
    );

    final name = parameter.regionName?.trim();
    final code = parameter.regionCode?.trim();
    final primaryLabel = (name != null && name.isNotEmpty)
        ? name
        : (code != null && code.isNotEmpty)
        ? code
        : '—';

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '照合した地域（市区町村）',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(primaryLabel, style: titleStyle),
              if (name != null &&
                  name.isNotEmpty &&
                  code != null &&
                  code.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '地域コード $code',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                '端末の位置情報（緯度・経度）を、気象庁の市区町村区域データ（JMAマップ）に照合して特定しています。'
                'この地域に対応する震度データで地震履歴を絞り込んでいます。',
                style: bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScopeUnavailableBody extends StatelessWidget {
  const _ScopeUnavailableBody({required this.scope, required this.onRetry});

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = switch (scope) {
      HomeEarthquakeHistoryScope.currentLocation =>
        '現在地の市区町村を特定できません。位置情報の利用を許可してください。',
      HomeEarthquakeHistoryScope.designatedRegion => '指定地域が設定されていません。',
      HomeEarthquakeHistoryScope.nationwide => '',
    };

    if (message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (scope == HomeEarthquakeHistoryScope.currentLocation) ...[
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () async {
                final status = await Geolocator.checkPermission();
                if (status == LocationPermission.denied) {
                  await Geolocator.requestPermission();
                } else if (status == LocationPermission.deniedForever) {
                  await Geolocator.openAppSettings();
                }
                onRetry();
              },
              child: const Text('位置情報の取得を許可する'),
            ),
          ],
        ],
      ),
    );
  }
}

class _EarthquakeList extends StatelessWidget {
  const _EarthquakeList({required this.earthquakes});

  final List<EarthquakePartial> earthquakes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: earthquakes
          .take(3)
          .map(
            (item) => InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async => EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EarthquakeHistoryListTile(
                  visualDensity: VisualDensity.compact,
                  item: item,
                  showBackgroundColor: false,
                  intensityIconSize: 32,
                  titleTextColor: colorScheme.onSurfaceVariant,
                  descriptionTextColor: colorScheme.onSurfaceVariant,
                  magnitudeTextColor: colorScheme.onPrimaryContainer,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
