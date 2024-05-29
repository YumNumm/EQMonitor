import 'package:collection/collection.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_request.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_response.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_notifier.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_settings_saved_state.g.dart';

@riverpod
bool notificationRemoteSettingsHasChangedFromSavedState(
  NotificationRemoteSettingsHasChangedFromSavedStateRef ref,
) =>
    ref.watch(notificationRemoteSettingsSavedStateNotifierProvider) !=
    ref.watch(notificationRemoteSettingsNotifierProvider);

@Riverpod(keepAlive: true)
class NotificationRemoteSettingsSavedStateNotifier
    extends _$NotificationRemoteSettingsSavedStateNotifier {
  @override
  Future<NotificationRemoteSettingsState> build() async {
    final api = ref.read(eqApiProvider);
    final String? token;
    try {
      token = await ref.read(apiAuthenticationServiceProvider.future);
    } on Exception catch (e) {
      throw UnauthorizedException(
        innerException: e,
      );
    }
    final response = await api.auth.getNotificationSettings(
      authorization: 'Bearer $token',
    );
    final data = response.data;
    return _fromResponse(data);
  }

  Future<void> updateEarthquake({
    required NotificationSettingsRequest request,
  }) async {
    final token = await ref.read(apiAuthenticationServiceProvider.future);
    if (token == null) {
      throw UnauthorizedException();
    }

    final api = ref.read(eqApiProvider);
    await api.auth.updateEarthquakeSettings(
      request: request,
      authorization: 'Bearer $token',
    );

    final areaInformationPrefectureEarthquake =
        ref.read(jmaCodeTableProvider).areaInformationPrefectureEarthquake;

    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          earthquake: NotificationRemoteSettingsEarthquake(
            global: request.global?.minJmaIntensity,
            regions: request.regions
                    ?.map(
                      (r) {
                        final prefectureName =
                            areaInformationPrefectureEarthquake.nameFindByCode(
                          r.code,
                        );
                        if (prefectureName == null) {
                          return null;
                        }
                        return NotificationRemoteSettingsEarthquakeRegion(
                          minJmaIntensity: r.minIntensity,
                          regionId: r.code,
                          name: prefectureName,
                        );
                      },
                    )
                    .whereNotNull()
                    .toList() ??
                [],
          ),
        ),
      );
    }
  }

  Future<void> updateEew({
    required NotificationSettingsRequest request,
  }) async {
    final token = await ref.read(apiAuthenticationServiceProvider.future);
    if (token == null) {
      throw UnauthorizedException();
    }

    final api = ref.read(eqApiProvider);
    await api.auth.updateEewSettings(
      request: request,
      authorization: 'Bearer $token',
    );

    final areaForecastLocalEew =
        ref.read(jmaCodeTableProvider).areaForecastLocalEew;

    if (state case AsyncData(:final value)) {
      state = AsyncData(
        value.copyWith(
          eew: NotificationRemoteSettingsEew(
            global: request.global?.minJmaIntensity,
            regions: request.regions
                    ?.map(
                      (r) {
                        final regionName = areaForecastLocalEew.nameFindByCode(
                          r.code,
                        );
                        if (regionName == null) {
                          return null;
                        }
                        return NotificationRemoteSettingsEewRegion(
                          minJmaIntensity: r.minIntensity,
                          regionId: r.code,
                          name: regionName,
                        );
                      },
                    )
                    .whereNotNull()
                    .toList() ??
                [],
          ),
        ),
      );
    }
  }

  NotificationRemoteSettingsState _fromResponse(
    NotificationSettingsResponse response,
  ) {
    final areaInformationPrefectureEarthquake =
        ref.read(jmaCodeTableProvider).areaInformationPrefectureEarthquake;
    final areaForecastLocalEew =
        ref.read(jmaCodeTableProvider).areaForecastLocalEew;

    return NotificationRemoteSettingsState(
      earthquake: NotificationRemoteSettingsEarthquake(
        global: response.earthquake
            .firstWhereOrNull((r) => r.regionId == 0)
            ?.minJmaIntensity,
        regions: response.earthquake
            .where((r) => r.regionId != 0)
            .map(
              (r) {
                final prefecture = areaInformationPrefectureEarthquake
                    .nameFindByCode(r.regionId);
                if (prefecture == null) {
                  return null;
                }
                return NotificationRemoteSettingsEarthquakeRegion(
                  regionId: r.regionId,
                  minJmaIntensity: r.minJmaIntensity,
                  name: prefecture,
                );
              },
            )
            .whereNotNull()
            .toList(),
      ),
      eew: NotificationRemoteSettingsEew(
        global: response.eew
            .firstWhereOrNull((r) => r.regionId == 0)
            ?.minJmaIntensity,
        regions: response.eew
            .where((r) => r.regionId != 0)
            .map(
              (r) {
                final region = areaForecastLocalEew.nameFindByCode(r.regionId);
                if (region == null) {
                  return null;
                }

                return NotificationRemoteSettingsEewRegion(
                  regionId: r.regionId,
                  minJmaIntensity: r.minJmaIntensity,
                  name: region,
                );
              },
            )
            .whereNotNull()
            .toList(),
      ),
    );
  }
}

class UnauthorizedException implements Exception {
  UnauthorizedException({
    this.innerException,
  });

  final Exception? innerException;
}

extension _AreaInformationPrefectureEarthquake
    on AreaInformationPrefectureEarthquake {
  String? nameFindByCode(int code) =>
      items.firstWhereOrNull((e) => int.parse(e.code) == code)?.name;
}

extension _AreaForecastLocalEew on AreaForecastLocalEew {
  String? nameFindByCode(int code) =>
      items.firstWhereOrNull((e) => int.parse(e.code) == code)?.name;
}
