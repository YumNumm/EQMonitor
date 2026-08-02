import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeMapControllerCard extends StatelessWidget {
  const HomeMapControllerCard({
    super.key,
    this.onLayerButtonTap,
    this.onLocationButtonTap,
    this.isLocationButtonEnabled = true,
    this.onDebugButtonTap,
    this.onLabelDebugButtonTap,
  });

  final void Function()? onLayerButtonTap;
  final void Function()? onLocationButtonTap;
  final bool isLocationButtonEnabled;
  final void Function()? onDebugButtonTap;
  final void Function()? onLabelDebugButtonTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    final divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.xs),
      child: Divider(height: 0, color: colorTheme.outlineVariant),
    );

    Future<void> hapticFeedback() async => HapticFeedback.lightImpact();

    return Card(
      color: colorTheme.surfaceContainerHigh.withValues(alpha: 0.92),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.md),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(spacing.sm),
                        child: const Icon(Icons.layers_rounded),
                      ),
                      onTap: () async {
                        await hapticFeedback();
                        onLayerButtonTap?.call();
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(spacing.sm),
                        child: Icon(
                          Icons.home_rounded,
                          color: isLocationButtonEnabled
                              ? null
                              : colorTheme.onSurface.withValues(alpha: 0.38),
                        ),
                      ),
                      onTap: isLocationButtonEnabled
                          ? () async {
                              await hapticFeedback();
                              onLocationButtonTap?.call();
                            }
                          : null,
                    ),
                    if (onLabelDebugButtonTap != null)
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(spacing.sm),
                          child: const Icon(Icons.label_rounded),
                        ),
                        onTap: () async {
                          await hapticFeedback();
                          onLabelDebugButtonTap?.call();
                        },
                      ),
                    if (onDebugButtonTap != null)
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(spacing.sm),
                          child: const Icon(Icons.bug_report_rounded),
                        ),
                        onTap: () async {
                          await hapticFeedback();
                          onDebugButtonTap?.call();
                        },
                      ),
                  ]
                  .mapIndexed((index, child) => [if (index > 0) divider, child])
                  .flattened
                  .toList(),
        ),
      ),
    );
  }
}
