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
  });

  final void Function()? onLayerButtonTap;
  final void Function()? onLocationButtonTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    final divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.xs),
      child: Divider(height: 0, color: color.outlineSoft),
    );

    void hapticFeedback() => unawaited(HapticFeedback.lightImpact());

    return Card(
      color: color.surfaceCard.withValues(alpha: 0.92),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shape.md),
        side: BorderSide(color: color.outlineSoft),
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
                        hapticFeedback();
                        onLayerButtonTap?.call();
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(spacing.sm),
                        child: const Icon(Icons.home_rounded),
                      ),
                      onTap: () {
                        hapticFeedback();
                        onLocationButtonTap?.call();
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
