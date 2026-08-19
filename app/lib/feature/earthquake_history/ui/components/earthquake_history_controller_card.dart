import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class EarthquakeHistoryControllerCard extends StatelessWidget {
  const new({
    super.key,
    this.onLocationButtonTap,
    this.onDebugButtonTap,
  });

  final void Function()? onLocationButtonTap;
  final void Function()? onDebugButtonTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Divider(height: 0),
    );

    Future<void> hapticFeedback() async => HapticFeedback.lightImpact();

    return Card(
      color: designSystem.colorTheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.home_rounded),
                      ),
                      onTap: () async {
                        await hapticFeedback();
                        onLocationButtonTap?.call();
                      },
                    ),
                    if (onDebugButtonTap != null)
                      InkWell(
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.bug_report_rounded),
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
