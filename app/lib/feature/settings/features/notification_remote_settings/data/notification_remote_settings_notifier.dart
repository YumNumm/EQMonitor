import 'dart:developer';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_request.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationRemoteSettingsNotifier
    extends _$NotificationRemoteSettingsNotifier {
  @override
  Future<NotificationRemoteSettingsState> build() async {
    final savedState =
        ref.watch(notificationRemoteSettingsSavedStateNotifierProvider.future);
    return savedState;
  }

  void updateEarthquakeGlobal(JmaForecastIntensity? global) {
    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          earthquake: NotificationRemoteSettingsEarthquake(
            global: global,
            regions: value.earthquake.regions,
          ),
        ),
      );
    } else {
      throw Exception('State is not AsyncData');
    }
  }

  void updateEarthquakeRegions(
    List<NotificationRemoteSettingsEarthquakeRegion> regions,
  ) {
    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          earthquake: NotificationRemoteSettingsEarthquake(
            global: value.earthquake.global,
            regions: regions,
          ),
        ),
      );
    } else {
      throw Exception('State is not AsyncData');
    }
  }

  void updateEewGlobal(JmaForecastIntensity? global) {
    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          eew: NotificationRemoteSettingsEew(
            global: global,
            regions: value.eew.regions,
          ),
        ),
      );
    } else {
      throw Exception('State is not AsyncData');
    }
  }

  void updateEewRegions(List<NotificationRemoteSettingsEewRegion> regions) {
    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          eew: NotificationRemoteSettingsEew(
            global: value.eew.global,
            regions: regions,
          ),
        ),
      );
    } else {
      throw Exception('State is not AsyncData');
    }
  }

  Future<void> save() async {
    final savedState = ref
        .read(notificationRemoteSettingsSavedStateNotifierProvider)
        .valueOrNull;
    if (savedState == null) {
      throw Exception('Saved state is null');
    }
    if (state case AsyncData(:final value)) {
      if (value.earthquake != savedState.earthquake) {
        final global = value.earthquake.global;
        log('Earthquake要素を更新中...', name: 'NotificationRemoteSettingsNotifier');
        await ref
            .read(notificationRemoteSettingsSavedStateNotifierProvider.notifier)
            .updateEarthquake(
              request: NotificationSettingsRequest(
                global: global != null
                    ? NotificationSettingsGlobal(
                        minJmaIntensity: global,
                      )
                    : null,
                regions: value.earthquake.regions
                    .where(
                      (r) => global == null || r.minJmaIntensity < global,
                    )
                    .map(
                      (r) => NotificationSettingsRegion(
                        code: r.regionId,
                        minIntensity: r.minJmaIntensity,
                      ),
                    )
                    .toList(),
              ),
            );
      } else {
        log(
          'Earthquake要素は更新されていません',
          name: 'NotificationRemoteSettingsNotifier',
        );
      }
      if (value.eew != savedState.eew) {
        final global = value.eew.global;
        log('EEW要素を更新中...', name: 'NotificationRemoteSettingsNotifier');
        await ref
            .read(notificationRemoteSettingsSavedStateNotifierProvider.notifier)
            .updateEew(
              request: NotificationSettingsRequest(
                global: global != null
                    ? NotificationSettingsGlobal(
                        minJmaIntensity: global,
                      )
                    : null,
                regions: value.eew.regions
                    .map(
                      (r) => NotificationSettingsRegion(
                        code: r.regionId,
                        minIntensity: r.minJmaIntensity,
                      ),
                    )
                    .toList(),
              ),
            );
      } else {
        log('EEW要素は更新されていません', name: 'NotificationRemoteSettingsNotifier');
      }
    } else {
      throw Exception('State is not AsyncData');
    }
    ref.invalidateSelf();
  }
}
