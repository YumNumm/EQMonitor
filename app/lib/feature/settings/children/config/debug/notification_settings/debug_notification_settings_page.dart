// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor_api/export.dart' hide JmaIntensity;
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// エラーメッセージをフォーマットするヘルパー関数
String _formatError(Object error) {
  if (error is DioException) {
    final buffer = StringBuffer();
    buffer.writeln('Error: ${error.type}');

    if (error.response != null) {
      final response = error.response!;
      buffer.writeln('Status Code: ${response.statusCode}');
      buffer.writeln('Status Message: ${response.statusMessage ?? 'N/A'}');

      if (response.data != null) {
        buffer.writeln('Response Body:');
        try {
          if (response.data is Map || response.data is List) {
            buffer.write(
              const JsonEncoder.withIndent('  ').convert(response.data),
            );
          } else {
            buffer.write(response.data.toString());
          }
        } catch (e) {
          buffer.write(response.data.toString());
        }
      }
    } else {
      buffer.writeln('Message: ${error.message}');
    }

    return buffer.toString();
  }
  return error.toString();
}

class DebugNotificationSettingsPage extends HookConsumerWidget {
  const DebugNotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceIdController = useTextEditingController();

    // States for each category
    final generalState = useState<AsyncValue<NotificationSettingsResponse>?>(null);
    final earthquakeState =
        useState<AsyncValue<EarthquakeSettingsResponse>?>(null);
    final eewState = useState<AsyncValue<EewSettingsResponse>?>(null);
    final earthquakeRegionsState = useState<AsyncValue<List<RegionSettingResponse>>?>(
      null,
    );
    final eewRegionsState = useState<AsyncValue<List<RegionSettingResponse>>?>(null);

    // Editable values
    final tsunamiEnabled = useState<bool>(true);
    final trainingEnabled = useState<bool>(false);

    final earthquakeEnabled = useState<bool>(true);
    final soundMode = useState<IntensitySoundMode>(
      IntensitySoundMode.maxIntensity,
    );
    final hypocenterUpdateEnabled = useState<bool>(false);
    final estimatedIntensityEnabled = useState<bool>(false);

    final eewEnabled = useState<bool>(true);
    final overrideSilentMode = useState<bool>(false);
    final eewSoundMode = useState<IntensitySoundMode>(
      IntensitySoundMode.maxIntensity,
    );
    final startLiveActivity = useState<bool>(true);

    final deviceIdAsync = ref.watch(deviceIdProvider);

    useEffect(
      () {
        deviceIdAsync.whenData((deviceId) {
          if (deviceIdController.text.isEmpty) {
            deviceIdController.text = deviceId;
          }
        });
        return null;
      },
      [deviceIdAsync],
    );

    // Update values when state changes
    useEffect(
      () {
        generalState.value?.whenData((data) {
          tsunamiEnabled.value = data.tsunamiEnabled;
          trainingEnabled.value = data.trainingEnabled;
        });
        return null;
      },
      [generalState.value],
    );

    useEffect(
      () {
        earthquakeState.value?.whenData((data) {
          earthquakeEnabled.value = data.enabled;
          soundMode.value = data.sound.mode;
          hypocenterUpdateEnabled.value = data.hypocenterUpdateEnabled;
          estimatedIntensityEnabled.value = data.estimatedIntensityEnabled;
        });
        return null;
      },
      [earthquakeState.value],
    );

    useEffect(
      () {
        eewState.value?.whenData((data) {
          eewEnabled.value = data.enabled;
          overrideSilentMode.value = data.overrideSilentMode;
          eewSoundMode.value = data.sound.mode;
          startLiveActivity.value = data.startLiveActivity;
        });
        return null;
      },
      [eewState.value],
    );

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification Settings',
          style: TextStyle(fontFamily: FontFamily.notoSansMono),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Device ID Input
                BorderedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device ID',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.notoSansMono,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: deviceIdController,
                        decoration: const InputDecoration(
                          hintText: 'Enter device ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // General Notification Settings
                BorderedContainer(
                  child: Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        '全般通知設定',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      initiallyExpanded: true,
                      children: [
                        SwitchListTile(
                          title: const Text('津波通知'),
                          subtitle: const Text('Tsunami notifications'),
                          value: tsunamiEnabled.value,
                          onChanged: (value) => tsunamiEnabled.value = value,
                        ),
                        SwitchListTile(
                          title: const Text('訓練通知'),
                          subtitle: const Text('Training notifications'),
                          value: trainingEnabled.value,
                          onChanged: (value) => trainingEnabled.value = value,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        generalState.value =
                                            const AsyncValue<
                                              NotificationSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .getV2DeviceDeviceIdSettingsNotification(
                                                deviceId:
                                                    deviceIdController.text,
                                              );
                                          generalState.value = AsyncValue.data(
                                            response.data,
                                          );
                                        } catch (e, s) {
                                          generalState.value =
                                              AsyncValue<
                                                NotificationSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Get'),
                              ),
                              FilledButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        generalState.value =
                                            const AsyncValue<
                                              NotificationSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .patchV2DeviceDeviceIdSettingsNotification(
                                                deviceId:
                                                    deviceIdController.text,
                                                body:
                                                    NotificationSettingsRequest(
                                                      tsunamiEnabled:
                                                          tsunamiEnabled.value,
                                                      trainingEnabled:
                                                          trainingEnabled.value,
                                                    ),
                                              );
                                          generalState.value = AsyncValue.data(
                                            response.data,
                                          );
                                        } catch (e, s) {
                                          generalState.value =
                                              AsyncValue<
                                                NotificationSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.upload, size: 18),
                                label: const Text('Update'),
                              ),
                            ],
                          ),
                        ),
                        if (generalState.value != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SelectableText(
                                switch (generalState.value!) {
                                  AsyncData(:final value) =>
                                    const JsonEncoder.withIndent('  ').convert({
                                      'tsunami_enabled': value.tsunamiEnabled,
                                      'training_enabled': value.trainingEnabled,
                                    }),
                                  AsyncError(:final error) => _formatError(
                                    error,
                                  ),
                                  _ => 'Loading...',
                                },
                                style: TextStyle(
                                  fontFamily: FontFamily.notoSansMono,
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Earthquake Notification Settings
                BorderedContainer(
                  child: Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        '地震通知設定',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        SwitchListTile(
                          title: const Text('地震通知'),
                          subtitle: const Text('Earthquake notifications'),
                          value: earthquakeEnabled.value,
                          onChanged: (value) => earthquakeEnabled.value = value,
                        ),
                        ListTile(
                          title: const Text('サウンドモード'),
                          subtitle: Text(soundMode.value.toString()),
                          trailing: DropdownButton<IntensitySoundMode>(
                            value: soundMode.value,
                            items: const [
                              DropdownMenuItem(
                                value: IntensitySoundMode.maxIntensity,
                                child: Text('Max Intensity'),
                              ),
                              DropdownMenuItem(
                                value: IntensitySoundMode.locationIntensity,
                                child: Text('Location Intensity'),
                              ),
                              DropdownMenuItem(
                                value: IntensitySoundMode.registeredMax,
                                child: Text('Registered Max'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                soundMode.value = value;
                              }
                            },
                          ),
                        ),
                        SwitchListTile(
                          title: const Text('震源更新通知'),
                          subtitle: const Text('Hypocenter update enabled'),
                          value: hypocenterUpdateEnabled.value,
                          onChanged: (value) =>
                              hypocenterUpdateEnabled.value = value,
                        ),
                        SwitchListTile(
                          title: const Text('推定震度通知'),
                          subtitle: const Text('Estimated intensity enabled'),
                          value: estimatedIntensityEnabled.value,
                          onChanged: (value) =>
                              estimatedIntensityEnabled.value = value,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        earthquakeState.value =
                                            const AsyncValue<
                                              EarthquakeSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .getV2DeviceDeviceIdSettingsEarthquake(
                                                deviceId:
                                                    deviceIdController.text,
                                              );
                                          earthquakeState.value =
                                              AsyncValue.data(response.data);
                                        } catch (e, s) {
                                          earthquakeState.value =
                                              AsyncValue<
                                                EarthquakeSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Get'),
                              ),
                              FilledButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        earthquakeState.value =
                                            const AsyncValue<
                                              EarthquakeSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .patchV2DeviceDeviceIdSettingsEarthquake(
                                                deviceId:
                                                    deviceIdController.text,
                                                body:
                                                    EarthquakeSettingsRequest(
                                                      enabled: earthquakeEnabled
                                                          .value,
                                                      sound: SoundSettings(
                                                        mode: soundMode.value,
                                                      ),
                                                      hypocenterUpdateEnabled:
                                                          hypocenterUpdateEnabled
                                                              .value,
                                                      estimatedIntensityEnabled:
                                                          estimatedIntensityEnabled
                                                              .value,
                                                    ),
                                              );
                                          earthquakeState.value =
                                              AsyncValue.data(response.data);
                                        } catch (e, s) {
                                          earthquakeState.value =
                                              AsyncValue<
                                                EarthquakeSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.upload, size: 18),
                                label: const Text('Update'),
                              ),
                            ],
                          ),
                        ),
                        if (earthquakeState.value != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SelectableText(
                                switch (earthquakeState.value!) {
                                  AsyncData(:final value) =>
                                    const JsonEncoder.withIndent('  ').convert({
                                      'enabled': value.enabled,
                                      'sound': {
                                        'mode': value.sound.mode.toString(),
                                        'map': value.sound.map,
                                      },
                                      'hypocenter_update_enabled':
                                          value.hypocenterUpdateEnabled,
                                      'estimated_intensity_enabled':
                                          value.estimatedIntensityEnabled,
                                    }),
                                  AsyncError(:final error) => _formatError(
                                    error,
                                  ),
                                  _ => 'Loading...',
                                },
                                style: TextStyle(
                                  fontFamily: FontFamily.notoSansMono,
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // EEW Notification Settings
                BorderedContainer(
                  child: Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'EEW通知設定',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        SwitchListTile(
                          title: const Text('EEW通知'),
                          subtitle: const Text('EEW notifications'),
                          value: eewEnabled.value,
                          onChanged: (value) => eewEnabled.value = value,
                        ),
                        SwitchListTile(
                          title: const Text('サイレントモード上書き'),
                          subtitle: const Text('Override silent mode'),
                          value: overrideSilentMode.value,
                          onChanged: (value) =>
                              overrideSilentMode.value = value,
                        ),
                        ListTile(
                          title: const Text('サウンドモード'),
                          subtitle: Text(eewSoundMode.value.toString()),
                          trailing: DropdownButton<IntensitySoundMode>(
                            value: eewSoundMode.value,
                            items: const [
                              DropdownMenuItem(
                                value: IntensitySoundMode.maxIntensity,
                                child: Text('Max Intensity'),
                              ),
                              DropdownMenuItem(
                                value: IntensitySoundMode.locationIntensity,
                                child: Text('Location Intensity'),
                              ),
                              DropdownMenuItem(
                                value: IntensitySoundMode.registeredMax,
                                child: Text('Registered Max'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                eewSoundMode.value = value;
                              }
                            },
                          ),
                        ),
                        SwitchListTile(
                          title: const Text('Live Activity開始'),
                          subtitle: const Text('Start live activity'),
                          value: startLiveActivity.value,
                          onChanged: (value) => startLiveActivity.value = value,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        eewState.value =
                                            const AsyncValue<
                                              EewSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .getV2DeviceDeviceIdSettingsEew(
                                                deviceId:
                                                    deviceIdController.text,
                                              );
                                          eewState.value = AsyncValue.data(
                                            response.data,
                                          );
                                        } catch (e, s) {
                                          eewState.value =
                                              AsyncValue<
                                                EewSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Get'),
                              ),
                              FilledButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        eewState.value =
                                            const AsyncValue<
                                              EewSettingsResponse
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .patchV2DeviceDeviceIdSettingsEew(
                                                deviceId:
                                                    deviceIdController.text,
                                                body:
                                                    EewSettingsRequest(
                                                      enabled: eewEnabled.value,
                                                      overrideSilentMode:
                                                          overrideSilentMode
                                                              .value,
                                                      sound: SoundSettings(
                                                        mode:
                                                            eewSoundMode.value,
                                                      ),
                                                      startLiveActivity:
                                                          startLiveActivity
                                                              .value,
                                                    ),
                                              );
                                          eewState.value = AsyncValue.data(
                                            response.data,
                                          );
                                        } catch (e, s) {
                                          eewState.value =
                                              AsyncValue<
                                                EewSettingsResponse
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.upload, size: 18),
                                label: const Text('Update'),
                              ),
                            ],
                          ),
                        ),
                        if (eewState.value != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SelectableText(
                                switch (eewState.value!) {
                                  AsyncData(:final value) =>
                                    const JsonEncoder.withIndent('  ').convert({
                                      'enabled': value.enabled,
                                      'override_silent_mode':
                                          value.overrideSilentMode,
                                      'sound': {
                                        'mode': value.sound.mode.toString(),
                                        'map': value.sound.map,
                                      },
                                      'start_live_activity':
                                          value.startLiveActivity,
                                    }),
                                  AsyncError(:final error) => _formatError(
                                    error,
                                  ),
                                  _ => 'Loading...',
                                },
                                style: TextStyle(
                                  fontFamily: FontFamily.notoSansMono,
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Earthquake Regions
                BorderedContainer(
                  child: Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        '地震 地域設定',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        earthquakeRegionsState.value =
                                            const AsyncValue<
                                              List<RegionSettingResponse>
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .getV2DeviceDeviceIdSettingsEarthquakeRegions(
                                                deviceId:
                                                    deviceIdController.text,
                                              );
                                          earthquakeRegionsState.value =
                                              AsyncValue.data(response.data);
                                        } catch (e, s) {
                                          earthquakeRegionsState.value =
                                              AsyncValue<
                                                List<RegionSettingResponse>
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Get Regions'),
                              ),
                            ],
                          ),
                        ),
                        if (earthquakeRegionsState.value != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SelectableText(
                                switch (earthquakeRegionsState.value!) {
                                  AsyncData(:final value) =>
                                    const JsonEncoder.withIndent('  ').convert(
                                      value
                                          .map(
                                            (e) => {
                                              'region_id': e.regionId,
                                              'region_name': e.regionName,
                                              'is_current_location':
                                                  e.isCurrentLocation,
                                              'min_jma_intensity':
                                                  e.minJmaIntensity.toString(),
                                              'created_at': e.createdAt,
                                              'updated_at': e.updatedAt,
                                            },
                                          )
                                          .toList(),
                                    ),
                                  AsyncError(:final error) => _formatError(
                                    error,
                                  ),
                                  _ => 'Loading...',
                                },
                                style: TextStyle(
                                  fontFamily: FontFamily.notoSansMono,
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // EEW Regions
                BorderedContainer(
                  child: Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'EEW 地域設定',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: deviceIdController.text.isEmpty
                                    ? null
                                    : () async {
                                        eewRegionsState.value =
                                            const AsyncValue<
                                              List<RegionSettingResponse>
                                            >.loading();
                                        try {
                                          final response = await ref
                                              .read(apiClientProvider)
                                              .device
                                              .getV2DeviceDeviceIdSettingsEewRegions(
                                                deviceId:
                                                    deviceIdController.text,
                                              );
                                          eewRegionsState.value =
                                              AsyncValue.data(response.data);
                                        } catch (e, s) {
                                          eewRegionsState.value =
                                              AsyncValue<
                                                List<RegionSettingResponse>
                                              >.error(e, s);
                                        }
                                      },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Get Regions'),
                              ),
                            ],
                          ),
                        ),
                        if (eewRegionsState.value != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SelectableText(
                                switch (eewRegionsState.value!) {
                                  AsyncData(:final value) =>
                                    const JsonEncoder.withIndent('  ').convert(
                                      value
                                          .map(
                                            (e) => {
                                              'region_id': e.regionId,
                                              'region_name': e.regionName,
                                              'is_current_location':
                                                  e.isCurrentLocation,
                                              'min_jma_intensity':
                                                  e.minJmaIntensity.toString(),
                                              'created_at': e.createdAt,
                                              'updated_at': e.updatedAt,
                                            },
                                          )
                                          .toList(),
                                    ),
                                  AsyncError(:final error) => _formatError(
                                    error,
                                  ),
                                  _ => 'Loading...',
                                },
                                style: TextStyle(
                                  fontFamily: FontFamily.notoSansMono,
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
