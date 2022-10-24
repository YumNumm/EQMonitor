import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:eqmonitor/provider/init/device_info.dart';
import 'package:eqmonitor/provider/init/kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/ui/view/setting/component/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeveloperDebugPage extends HookConsumerWidget {
  const DeveloperDebugPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグ情報'),
      ),
      body: SettingsSection(
        title: 'デバッグ情報',
        children: [
          SettingsSection(
            title: 'EEW WebSocket',
            children: [
              ListTile(
                title: const Text('Join Once'),
                subtitle: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .channel
                          ?.joinedOnce
                          .toString() ??
                      'Unknown',
                ),
              ),
              ListTile(
                title: const Text('Connection State'),
                subtitle: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .channel
                          ?.socket
                          .connState
                          ?.toString() ??
                      'Unknown',
                ),
              ),
              ListTile(
                title: const Text('Topic'),
                subtitle: Text(
                  ref.watch(eewHistoryProvider).channel?.topic ?? 'Unknown',
                ),
              ),
              ListTile(
                title: const Text('HeartbeatInterval(ms)'),
                subtitle: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .channel
                          ?.socket
                          .heartbeatIntervalMs
                          .toString() ??
                      'Unknown',
                ),
              ),
              ListTile(
                title: const Text('LongPoller T/O(ms)'),
                subtitle: Text(
                  ref
                          .watch(eewHistoryProvider)
                          .channel
                          ?.socket
                          .longpollerTimeout
                          .toString() ??
                      'Unknown',
                ),
              ),
            ],
          ),
          SettingsSection(
            title: 'Providers',
            children: [
              ListTile(
                title: const Text('ApplicationSupportDirectoryProvider'),
                subtitle: Text(
                  ref.watch(applicationSupportDirectoryProvider).path,
                ),
              ),
              ListTile(
                title: const Text('kyoshinKansokutenProvider'),
                subtitle: Text(
                  ref.watch(kyoshinKansokutenProvider).length.toString(),
                ),
              ),
              ListTile(
                title: const Text('mapAreaForecastLocalEProvider'),
                subtitle: Text(
                  ref.watch(mapAreaForecastLocalEProvider).length.toString(),
                ),
              ),
              ListTile(
                title: const Text('travelTimeProvider'),
                subtitle: Text(
                  ref.watch(travelTimeProvider).length.toString(),
                ),
              ),
              ListTile(
                title: const Text('sharedPreferencesProvder - keys'),
                onTap: () {
                  ref.read(sharedPreferencesProvder).clear();
                },
                subtitle: Text(
                  const JsonEncoder.withIndent(' ').convert(
                    ref.watch(sharedPreferencesProvder).getKeys().toList()
                      ..sort((a, b) => a.compareTo(b)),
                  ),
                ),
              ),
              if (Platform.isAndroid)
                ListTile(
                  title: const Text('androidDeviceInfoProvider'),
                  subtitle: Text(
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
