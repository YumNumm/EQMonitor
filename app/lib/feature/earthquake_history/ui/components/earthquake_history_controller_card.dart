import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EarthquakeHistoryControllerCard extends StatelessWidget {
  const EarthquakeHistoryControllerCard({
    super.key,
    this.onLayerButtonTap,
    this.onLocationButtonTap,
  });

  final void Function()? onLayerButtonTap;
  final void Function()? onLocationButtonTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Divider(height: 0),
    );

    void hapticFeedback() => unawaited(HapticFeedback.lightImpact());

    return Card(
      color: colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.layers_rounded),
                      ),
                      onTap: () async {
                        hapticFeedback();
                        onLayerButtonTap?.call();
                      },
                    ),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.home_rounded),
                      ),
                      onTap: () {
                        hapticFeedback();
                        onLocationButtonTap?.call();
                      },
                    ),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.folder_copy_outlined),
                      ),
                      onTap: () async {
                        hapticFeedback();
                        await showEarthquakeHistoryDetailConfigDialog(
                          context,
                          showCitySelector: false,
                          hasLpgmIntensity: false,
                        );
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
