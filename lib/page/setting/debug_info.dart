import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:eqmonitor/provider/init/device_info.dart';
import 'package:eqmonitor/provider/init/kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class DeveloperDebugPage extends HookConsumerWidget {
  const DeveloperDebugPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグ情報'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('EEW WebSocket'),
            tiles: [
              SettingsTile(
                title: const Text('Join Once'),
                value: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .subscription
                          ?.joinedOnce
                          .toString() ??
                      'Unknown',
                ),
              ),
              SettingsTile(
                title: const Text('Connection State'),
                value: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .subscription
                          ?.socket
                          .connState
                          ?.toString() ??
                      'Unknown',
                ),
              ),
              SettingsTile(
                title: const Text('Topic'),
                value: Text(
                  ref.watch(eewHistoryProvider).subscription?.topic ??
                      'Unknown',
                ),
              ),
              SettingsTile(
                title: const Text('HeartbeatInterval(ms)'),
                value: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .subscription
                          ?.socket
                          .heartbeatIntervalMs
                          .toString() ??
                      'Unknown',
                ),
              ),
              SettingsTile(
                title: const Text('LongPoller T/O(ms)'),
                value: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .subscription
                          ?.socket
                          .longpollerTimeout
                          .toString() ??
                      'Unknown',
                ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Providers'),
            tiles: [
              SettingsTile(
                title: const Text('ApplicationSupportDirectoryProvider'),
                value: Text(
                  ref.watch(applicationSupportDirectoryProvider).path,
                ),
              ),
              SettingsTile(
                title: const Text('kyoshinKansokutenProvider'),
                value: Text(
                  ref.watch(kyoshinKansokutenProvider).length.toString(),
                ),
              ),
              SettingsTile(
                title: const Text('mapAreaForecastLocalEProvider'),
                value: Text(
                  ref.watch(mapAreaForecastLocalEProvider).length.toString(),
                ),
              ),
              SettingsTile(
                title: const Text('TravelTimeProvider'),
                value: Text(
                  ref.watch(TravelTimeProvider).length.toString(),
                ),
              ),
              SettingsTile(
                title: const Text('sharedPreferencesProvder - keys'),
                onPressed: (context) {
                  ref.read(sharedPreferencesProvder).clear();
                },
                value: Text(
                  const JsonEncoder.withIndent(' ').convert(
                    ref.watch(sharedPreferencesProvder).getKeys().toList()
                      ..sort((a, b) => a.compareTo(b)),
                  ),
                ),
              ),
              if (Platform.isAndroid)
                SettingsTile(
                  title: const Text('androidDeviceInfoProvider'),
                  value: Text(
                    const JsonEncoder.withIndent(' ')
                        .convert(ref.watch(androidDeviceInfoProvider).toMap()),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
