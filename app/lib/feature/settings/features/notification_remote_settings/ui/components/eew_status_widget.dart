import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/extension/jma_forecast_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:flutter/material.dart';

class EewStatusWidget extends StatelessWidget {
  const EewStatusWidget({
    super.key,
    required this.eew,
    required this.action,
  });

  final NotificationRemoteSettingsEew eew;
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
                  '緊急地震速報',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                EewNotificationStatusWidget(eew: eew),
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

class EewNotificationStatusWidget extends StatelessWidget {
  const EewNotificationStatusWidget({
    super.key,
    required this.eew,
  });

  final NotificationRemoteSettingsEew eew;

  @override
  Widget build(BuildContext context) {
    final enabledRegions = eew.regions.where(
      (e) => (eew.global == null) || e.minJmaIntensity < (eew.global!),
    );

    if (eew.global == null && eew.regions.isEmpty) {
      return const Text('地震情報の通知は無効です');
    }
    return Text.rich(
      TextSpan(
        children: (eew.global == JmaForecastIntensity.zero)
            ? [
                const TextSpan(
                  text: 'すべての緊急地震速報を通知します',
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
                if (eew.global != null) ...[
                  const TextSpan(
                    text: '・任意の地域で',
                  ),
                  TextSpan(
                    text: '震度'
                        '${eew.global!.type.fromPlusMinus}'
                        '${eew.global != JmaForecastIntensity.seven ? "以上" : ""}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: 'が予想',
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
                            text: 'が予想',
                          ),
                        ],
                      )
                      .flattened,
              ],
      ),
    );
  }
}
