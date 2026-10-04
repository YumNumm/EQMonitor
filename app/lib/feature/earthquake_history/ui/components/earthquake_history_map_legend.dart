import 'dart:ui' show lerpDouble;

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

const _legendIconSize = 24.0;

class EarthquakeHistoryMapLegend extends StatelessWidget {
  const new({
    required this.intensity,
    this.displayMode = IntensityDisplayMode.jma,
    this.shindoDbTree,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final IntensityDisplayMode displayMode;
  final ShindoDbIntensityTree? shindoDbTree;

  @override
  Widget build(BuildContext context) {
    final tree = shindoDbTree;
    if (tree != null) {
      return _ShindoDbLegend(tree: tree);
    }
    return switch (displayMode) {
      .jma => _JmaLegend(intensity: intensity),
      .lpgm => _LpgmLegend(intensity: intensity),
      .estimated => const _JmaLegend(estimated: true),
    };
  }
}

class _JmaLegend extends StatelessWidget {
  const new({this.intensity, this.estimated = false});
  final EarthquakeIntensity? intensity;
  final bool estimated;

  @override
  Widget build(BuildContext context) {
    final levels = estimated
        ? <JmaIntensity>[
            .four,
            .fiveLower,
            .fiveUpper,
            .sixLower,
            .sixUpper,
            .seven,
          ]
        : switch (intensity) {
            final current? => {
              ...current.intensityTree.keys,
              ...current.regions.keys,
              if (current.maxIntensity != JmaIntensity.unknown)
                current.maxIntensity,
            }.toList(),
            null => <JmaIntensity>[],
          };
    levels.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    final estimatedColors = context.designSystem.colorTheme.estimatedIntensity;
    return _AnimatedLegend(
      label: estimated ? '推計震度' : '震度',
      entries: [
        for (final level in levels.where(
          (level) => level != JmaIntensity.fiveUnknown,
        ))
          (
            label: '震度${level.mainText}${level.suffix}',
            borderRadius: BorderRadius.circular(_legendIconSize / 4),
            icon: JmaIntensityIcon(
              intensity: level,
              type: .filled,
              size: _legendIconSize,
              colorEntry: estimated
                  ? estimatedColors.fromJmaIntensity(level)
                  : null,
            ),
          ),
      ],
    );
  }
}

class _LpgmLegend extends StatelessWidget {
  const new({required this.intensity});
  final EarthquakeIntensity? intensity;

  @override
  Widget build(BuildContext context) {
    final levels = switch (intensity) {
      final current? => {
        ...current.lpgmIntensityTree.keys,
        if (current.maxLpgmIntensity case final maximum?) maximum,
      }.where((level) => level != JmaLpgmIntensity.zero).toList(),
      null => <JmaLpgmIntensity>[],
    };
    levels.sort((a, b) => b.index.compareTo(a.index));
    return _AnimatedLegend(
      label: '長周期地震動階級',
      entries: [
        for (final level in levels)
          (
            label: '階級${level.label}',
            borderRadius: BorderRadius.circular(_legendIconSize / 5),
            icon: JmaLpgmIntensityIcon(
              intensity: level,
              type: .filled,
              size: _legendIconSize,
            ),
          ),
      ],
    );
  }
}

class _ShindoDbLegend extends StatelessWidget {
  const new({required this.tree});
  final ShindoDbIntensityTree tree;

  @override
  Widget build(BuildContext context) {
    final classes = tree.tree.keys.toList()
      ..sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    final colorTheme = context.designSystem.colorTheme;
    return _AnimatedLegend(
      label: '震度',
      entries: [
        for (final cls in classes.where((cls) => cls.colorJmaIntensity != null))
          (
            label: cls.sectionTitle,
            borderRadius: BorderRadius.circular(_legendIconSize / 4),
            icon: ShindoDbIntensityClassIcon(
              intensityClass: cls,
              size: _legendIconSize,
            ),
          ),
        if (classes.any((cls) => cls.colorJmaIntensity == null))
          (
            label: '震度不明',
            borderRadius: BorderRadius.circular(_legendIconSize / 4),
            icon: Container(
              width: _legendIconSize,
              height: _legendIconSize,
              decoration: BoxDecoration(
                color: colorTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(_legendIconSize / 4),
              ),
              child: Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    color: colorTheme.onSurface,
                    fontSize: _legendIconSize / 2,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _AnimatedLegend extends HookWidget {
  const new({required this.label, required this.entries});

  final String label;
  final List<({String label, BorderRadius borderRadius, Widget icon})> entries;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(true);
    final animation = useAnimationController(
      initialValue: 1,
      lowerBound: -0.2,
      upperBound: 1.2,
    );
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    const motion = M3EMotion.expressiveSpatialDefault;
    final spring = useMemoized(
      () => SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: motion.stiffness,
        ratio: motion.damping,
      ),
    );
    useEffect(() {
      if (disableAnimations) {
        animation.stop();
        animation.value = expanded.value ? 1 : 0;
      }
      return null;
    }, [disableAnimations, expanded.value]);

    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleStackCount = entries.length.clamp(1, 3);
    final stackedWidth = _legendIconSize + (visibleStackCount - 1) * spacing.sm;
    final expandedWidth =
        entries.length * _legendIconSize + (entries.length - 1) * spacing.xs;
    return Semantics(
      expanded: expanded.value,
      child: M3EButton(
        style: .tonal,
        semanticLabel:
            '$labelの凡例、${entries.map((entry) => entry.label).join('、')}',
        tooltip: expanded.value ? '凡例を折りたたむ' : '凡例を展開',
        decoration: M3EButtonDecoration.styleFrom(
          backgroundColor: designSystem.colorTheme.surface.withValues(
            alpha: 0.9,
          ),
          foregroundColor: designSystem.colorTheme.onSurface,
          elevation: 2,
          padding: EdgeInsets.all(spacing.sm),
          minimumSize: const Size(48, 48),
          borderRadius: designSystem.shape.card,
          motion: motion,
          haptic: .light,
        ),
        onPressed: () async {
          expanded.value = !expanded.value;
          final target = expanded.value ? 1.0 : 0.0;
          if (disableAnimations) {
            animation.value = target;
            return;
          }
          try {
            await animation
                .animateWith(
                  SpringSimulation(
                    spring,
                    animation.value,
                    target,
                    animation.velocity,
                  ),
                )
                .orCancel;
          } on TickerCanceled {
            // 連続タップや画面を閉じる操作で中断されたアニメーション。
          }
        },
        child: ExcludeSemantics(
          child: FittedBox(
            fit: .scaleDown,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final progress = animation.value;
                final shadowOpacity = entries.length > 1
                    ? 0.2 * (1 - progress.clamp(0.0, 1.0))
                    : 0.0;
                return SizedBox(
                  width: lerpDouble(stackedWidth, expandedWidth, progress),
                  height: _legendIconSize,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (var index = entries.length - 1; index >= 0; index--)
                        Positioned(
                          left: lerpDouble(
                            index.clamp(0, 2) * spacing.sm,
                            index * (_legendIconSize + spacing.xs),
                            progress,
                          ),
                          child: Opacity(
                            opacity: index < 3 ? 1 : progress.clamp(0.0, 1.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: entries[index].borderRadius,
                                boxShadow: [
                                  if (shadowOpacity > 0)
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: shadowOpacity,
                                      ),
                                      blurRadius: spacing.xs,
                                      offset: Offset(0, spacing.xs / 4),
                                    ),
                                ],
                              ),
                              child: entries[index].icon,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
