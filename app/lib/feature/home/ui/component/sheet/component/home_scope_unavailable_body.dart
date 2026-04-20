import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScopeUnavailableBody extends StatelessWidget {
  const HomeScopeUnavailableBody({
    required this.scope,
    required this.onRetry,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = switch (scope) {
      .currentLocation => '現在地の市区町村を特定できません。位置情報の利用を許可してください。',
      .custom => '指定地域が設定されていません。',
      .nationwide => '',
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
