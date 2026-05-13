import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_settings_notifier.g.dart';

@riverpod
class ShakeDetectionSettingsNotifier
    extends _$ShakeDetectionSettingsNotifier {
  static final addCurrentLocationMutation = Mutation<void>();
  static final removeEntryMutation = Mutation<void>();
  static final updateLevelMutation = Mutation<void>();

  @override
  Future<ShakeDetectionState> build() async {
    final deviceId = await ref.watch(deviceIdProvider.future);
    final repo = await ref.watch(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final (entriesResult, subRegionsResult) = await (
      repo.getShakeDetectionSettings(deviceId),
      repo.getShakeDetectionSubRegions(deviceId),
    ).wait;
    final rawEntries = switch (entriesResult) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    final subRegions = switch (subRegionsResult) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    return (
      entries: _resolveNames(rawEntries, subRegions),
      availableSubRegions: subRegions,
    );
  }

  /// バックグラウンド位置更新時に現在地エントリのsub_region_idを更新する。
  /// 現在地エントリが存在しない場合は何もしない（追加はユーザー操作で行う）。
  /// [cityCode] は market区町村コード（areaInformationCity）。対応するサブ地域が
  /// availableSubRegions に見つからない場合は null のまま維持する。
  /// 更新が実行された場合は true、変化なしまたはスキップの場合は false を返す。
  Future<bool> updateCurrentLocationSubRegion(String? cityCode) async {
    final current = state.requireValue;
    final existing =
        current.entries.where((e) => e.isCurrentLocation).firstOrNull;
    if (existing == null) {
      return false;
    }

    final newSubRegionId = cityCode == null
        ? null
        : current.availableSubRegions
              .where((s) => s.code == cityCode)
              .map((s) => s.id)
              .firstOrNull;

    if (existing.subRegionId == newSubRegionId) {
      return false;
    }

    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = current.entries.map((e) {
      return e.isCurrentLocation ? e.copyWith(subRegionId: newSubRegionId) : e;
    }).toList();
    final result = await repo.putShakeDetectionSettings(
      deviceId: deviceId,
      entries: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData((
          entries: _resolveNames(value, current.availableSubRegions),
          availableSubRegions: current.availableSubRegions,
        ));
        return true;
      case Failure(:final exception):
        talker.error(
          '[ShakeDetection] updateCurrentLocationSubRegion failure',
          exception,
        );
        throw exception;
    }
  }

  Future<void> addCurrentLocation({
    api.ShakeDetectionLevel level = api.ShakeDetectionLevel.medium,
  }) async {
    final current = state.requireValue;
    talker.debug(
      '[ShakeDetection] addCurrentLocation: entries=${current.entries.length}, '
      'hasCurrentLocation=${current.entries.any((e) => e.isCurrentLocation)}',
    );
    if (current.entries.any((e) => e.isCurrentLocation)) {
      return;
    }
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = [
      ...current.entries,
      ShakeDetectionEntry(
        id: '',
        subRegionId: null,
        subRegionName: null,
        minLevel: level,
        isCurrentLocation: true,
      ),
    ];
    final result = await repo.putShakeDetectionSettings(
      deviceId: deviceId,
      entries: updated,
    );
    talker.debug('[ShakeDetection] putShakeDetectionSettings result: $result');
    switch (result) {
      case Success(:final value):
        talker.debug(
          '[ShakeDetection] putShakeDetectionSettings success: entries=${value.length}',
        );
        state = AsyncData((
          entries: _resolveNames(value, current.availableSubRegions),
          availableSubRegions: current.availableSubRegions,
        ));
      case Failure(:final exception):
        talker.error('[ShakeDetection] putShakeDetectionSettings failure', exception);
        throw exception;
    }
  }

  Future<void> removeEntry(String entryId) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = current.entries.where((e) => e.id != entryId).toList();
    final result = await repo.putShakeDetectionSettings(
      deviceId: deviceId,
      entries: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData((
          entries: _resolveNames(value, current.availableSubRegions),
          availableSubRegions: current.availableSubRegions,
        ));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> updateLevel(
    String entryId,
    api.ShakeDetectionLevel newLevel,
  ) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = current.entries.map((e) {
      return e.id == entryId ? e.copyWith(minLevel: newLevel) : e;
    }).toList();
    final result = await repo.putShakeDetectionSettings(
      deviceId: deviceId,
      entries: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData((
          entries: _resolveNames(value, current.availableSubRegions),
          availableSubRegions: current.availableSubRegions,
        ));
      case Failure(:final exception):
        throw exception;
    }
  }

  List<ShakeDetectionEntry> _resolveNames(
    List<ShakeDetectionEntry> entries,
    List<ShakeDetectionSubRegion> subRegions,
  ) => entries.map((e) {
    final name = subRegions
        .where((s) => s.id == e.subRegionId)
        .map((s) => s.name)
        .firstOrNull;
    return e.copyWith(subRegionName: name);
  }).toList();
}
