import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_cache_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slots_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationSlotsNotifier extends _$NotificationSlotsNotifier {
  var _hasServedStoredSlots = false;
  var _revision = 0;

  /// 起動後の最初の構築だけ、端末に保存した前回値を返して裏でサーバーへ確認する。
  ///
  /// 変更後の再取得・明示的な再読み込み・端末の再登録後は、サーバーの応答を待つ。
  @override
  Future<List<NotificationSlot>> build() async {
    final revision = ++_revision;
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != .notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(notificationSlotRepositoryProvider.future);
    final cache = ref.read(notificationSlotCacheRepositoryProvider);
    if (!_hasServedStoredSlots) {
      _hasServedStoredSlots = true;
      final stored = await cache.read();
      if (stored != null) {
        await ref
            .read(deviceLocationConsumersRepositoryProvider)
            .updateSlots(stored);
        unawaited(
          revalidate(repository: repo, stored: stored, revision: revision),
        );
        return stored;
      }
    }
    final slots = await repo.getSlots();
    if (revision == _revision) {
      await cache.write(slots);
    }
    await ref
        .read(deviceLocationConsumersRepositoryProvider)
        .updateSlots(slots);
    return slots;
  }

  /// 前回値を公開した後にサーバーの値を取得し、差分があれば反映する。
  ///
  /// 取得に失敗した場合は前回値のまま進める。確認中に変更・再構築が
  /// あった場合は、古い応答で上書きしないよう結果を捨てる。
  Future<void> revalidate({
    required NotificationSlotRepository repository,
    required List<NotificationSlot> stored,
    required int revision,
  }) async {
    try {
      await future;
      final fresh = await repository.getSlots();
      if (!ref.mounted ||
          revision != _revision ||
          const ListEquality<NotificationSlot>().equals(fresh, stored)) {
        return;
      }
      final cache = ref.read(notificationSlotCacheRepositoryProvider);
      final consumers = ref.read(deviceLocationConsumersRepositoryProvider);
      state = AsyncData(fresh);
      await cache.write(fresh);
      await consumers.updateSlots(fresh);
    } on Object catch (error, stackTrace) {
      talker.warning(
        '[NotificationSlots] revalidation failed',
        error,
        stackTrace,
      );
    }
  }

  static final putCurrentLocationMutation = Mutation<void>();

  Future<void> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final currentLocationSlot = await repo.putCurrentLocation(
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    _revision++;
    await ref.read(deviceLocationConsumersRepositoryProvider).updateSlots([
      currentLocationSlot,
    ]);
    // Publish the authoritative write response before a fallible refetch.
    // Subsequent edits must not resurrect overrides removed by this write.
    final previous = state.value;
    final next = previous == null
        ? null
        : [
            for (final slot in previous)
              if (slot.id == currentLocationSlot.id)
                currentLocationSlot
              else
                slot,
            if (!previous.any((slot) => slot.id == currentLocationSlot.id))
              currentLocationSlot,
          ];
    if (next != null) {
      state = AsyncData(next);
    }
    ref.invalidateSelf();
    await storeSlots(next);
  }

  /// 変更後の一覧を端末に保存する。一覧が確定しない変更では保存値を消し、
  /// 次回の起動で変更前の値を返さないようにする。
  Future<void> storeSlots(List<NotificationSlot>? slots) async {
    final cache = ref.read(notificationSlotCacheRepositoryProvider);
    if (slots == null) {
      await cache.clear();
      return;
    }
    await cache.write(slots);
  }

  static final replaceSlotsMutation = Mutation<void>();

  Future<void> replaceSlots(List<NotificationSlotDraft> slots) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final replacedSlots = await repo.replaceSlots(slots);
    _revision++;
    await ref
        .read(deviceLocationConsumersRepositoryProvider)
        .updateSlots(replacedSlots);
    ref.invalidateSelf();
    await storeSlots(replacedSlots);
  }

  static final deleteCurrentLocationMutation = Mutation<void>();

  Future<void> deleteCurrentLocation() async {
    final currentSlots = await future;
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteCurrentLocation();
    _revision++;
    final remainingSlots = currentSlots
        .where((s) => s.slotType != NotificationSlotType.currentLocation)
        .toList();
    await ref
        .read(deviceLocationConsumersRepositoryProvider)
        .updateSlots(remainingSlots);
    ref.invalidateSelf();
    await storeSlots(remainingSlots);
  }

  static final putNationwideMutation = Mutation<void>();

  Future<void> putNationwide({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final updatedSlot = await repo.putNationwide(
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    _revision++;
    // Publish the authoritative write response before a fallible refetch.
    // Subsequent edits must not resurrect overrides removed by this write.
    final previous = state.value;
    final next = previous == null
        ? null
        : [
            for (final slot in previous)
              if (slot.id == updatedSlot.id) updatedSlot else slot,
            if (!previous.any((slot) => slot.id == updatedSlot.id)) updatedSlot,
          ];
    if (next != null) {
      state = AsyncData(next);
    }
    ref.invalidateSelf();
    await storeSlots(next);
  }

  static final deleteNationwideMutation = Mutation<void>();

  Future<void> deleteNationwide() async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteNationwide();
    _revision++;
    ref.invalidateSelf();
    await storeSlots(null);
  }

  static final addRegionMutation = Mutation<void>();

  Future<void> addRegion({
    required int regionId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.addRegion(
      regionId: regionId,
      regionName: regionName,
      cityCode: cityCode,
      cityName: cityName,
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    _revision++;
    ref.invalidateSelf();
    await storeSlots(null);
  }

  static final updateRegionMutation = Mutation<void>();

  Future<void> updateRegion({
    required String slotId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final updatedSlot = await repo.updateRegion(
      slotId: slotId,
      regionName: regionName,
      cityCode: cityCode,
      cityName: cityName,
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    _revision++;
    // Publish the authoritative write response before a fallible refetch.
    // Subsequent edits must not resurrect overrides removed by this write.
    final previous = state.value;
    final next = previous == null
        ? null
        : [
            for (final slot in previous)
              if (slot.id == updatedSlot.id) updatedSlot else slot,
            if (!previous.any((slot) => slot.id == updatedSlot.id)) updatedSlot,
          ];
    if (next != null) {
      state = AsyncData(next);
    }
    ref.invalidateSelf();
    await storeSlots(next);
  }

  static final removeRegionMutation = Mutation<void>();

  Future<void> removeRegion({required String slotId}) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.removeRegion(slotId: slotId);
    _revision++;
    ref.invalidateSelf();
    await storeSlots(null);
  }
}
