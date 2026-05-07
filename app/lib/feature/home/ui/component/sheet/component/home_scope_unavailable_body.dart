import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScopeUnavailableBody extends StatelessWidget {
  const HomeScopeUnavailableBody({
    required this.scope,
    required this.onRetry,
    this.onConfigureRegion,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onRetry;
  final VoidCallback? onConfigureRegion;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;
    final message = switch (scope) {
      .currentLocation => '現在地の市区町村を特定できません。位置情報の利用を許可してください。',
      .custom => '指定地域が設定されていません。',
      .nationwide => '',
    };

    if (message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.lg,
      ),
      child: Container(
        padding: EdgeInsets.all(spacing.lg),
        decoration: BoxDecoration(
          color: color.surfaceRaised,
          borderRadius: BorderRadius.circular(shape.lg),
          border: Border.all(color: color.outlineSoft),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              scope == HomeEarthquakeHistoryScope.currentLocation
                  ? Icons.location_off_outlined
                  : Icons.tune_outlined,
              color: designSystem.textColor.secondary,
            ),
            SizedBox(height: spacing.sm),
            Text(
              message,
              style: typography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (scope == HomeEarthquakeHistoryScope.currentLocation) ...[
              SizedBox(height: spacing.md),
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
            if (scope == HomeEarthquakeHistoryScope.custom &&
                onConfigureRegion != null) ...[
              SizedBox(height: spacing.md),
              FilledButton.tonal(
                onPressed: onConfigureRegion,
                child: const Text('地域を設定する'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
