import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/extension/jma_forecast_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:flutter/material.dart';

class EarthquakeStatusWidget extends StatelessWidget {
  const EarthquakeStatusWidget({
    super.key,
    required this.earthquake,
    required this.action,
  });

  final NotificationRemoteSettingsEarthquake earthquake;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    return BorderedContainer(
      margin: EdgeInsets.zero,
      elevation: 4,
      onPressed: action,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '地震情報',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                EarthquakeNotificationStatusText(earthquake: earthquake),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: action,
          ),
        ],
      ),
    );
  }
}

class EarthquakeNotificationStatusText extends StatelessWidget {
  const EarthquakeNotificationStatusText({
    super.key,
    required this.earthquake,
  });

  final NotificationRemoteSettingsEarthquake earthquake;

  @override
  Widget build(BuildContext context) {
    final enabledRegions = earthquake.regions.where(
      (e) =>
          (earthquake.global == null) ||
          e.minJmaIntensity < (earthquake.global!),
    );
    if (earthquake.global == null && earthquake.regions.isEmpty) {
      return const Text('地震情報の通知は無効です');
    }
    return Text.rich(
      TextSpan(
        children: (earthquake.global == JmaForecastIntensity.zero)
            ? [
                const TextSpan(
                  text: 'すべての地震情報を通知します',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            : [
                const TextSpan(
                  text: '以下の条件のいずれかを満たした時に通知します\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (earthquake.global != null) ...[
                  const TextSpan(
                    text: '・任意の地域で',
                  ),
                  TextSpan(
                    text: '震度'
                        '${earthquake.global!.type.fromPlusMinus}'
                        '${earthquake.global != JmaForecastIntensity.seven ? "以上" : ""}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: 'を観測',
                  ),
                ],
                if (enabledRegions.isNotEmpty)
                  ...enabledRegions
                      .mapIndexed(
                        (index, region) => [
                          TextSpan(
                            text: '\n・${region.name}で',
                          ),
                          TextSpan(
                            text:
                                '震度${region.minJmaIntensity.type.fromPlusMinus}'
                                '${region.minJmaIntensity != JmaForecastIntensity.seven ? "以上" : ""}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: 'を観測',
                          ),
                        ],
                      )
                      .flattened,
              ],
      ),
    );
  }
}
