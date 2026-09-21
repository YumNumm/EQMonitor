import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('successful deletion remains authoritative after failed refetch and next edit', () async {
    final entries = [
      for (final intensity in [JmaIntensity.one, JmaIntensity.three])
        NotificationOverride(
          minJmaIntensity: intensity,
          sound: 'default',
          interruptionLevel: InterruptionLevel.active,
        ),
    ];
    final initial = NotificationSlot(
      id: 'region',
      slotType: NotificationSlotType.region,
      regionId: 1,
      regionName: 'region',
      cityCode: null,
      cityName: null,
      displayOrder: 0,
      eewEnabled: true,
      eewMinIntensity: JmaIntensity.one,
      eewOverrides: const [],
      earthquakeEnabled: true,
      earthquakeMinIntensity: JmaIntensity.one,
      earthquakeOverrides: entries,
    );
    final repository = _Repository(initial);
    final container = ProviderContainer(
      overrides: [
        notificationSlotsProvider.overrideWith(() => _Notifier(initial)),
        notificationSlotRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(notificationSlotsProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(notificationSlotsProvider.future);
    final notifier = container.read(notificationSlotsProvider.notifier);
    await notifier.updateRegion(
      slotId: initial.id,
      earthquakeOverrides: [entries.last],
    );
    await expectLater(
      container.read(notificationSlotsProvider.future),
      throwsStateError,
    );
    final retained = container
        .read(notificationSlotsProvider)
        .value
        ?.single
        .earthquakeOverrides;
    expect(retained?.map((entry) => entry.minJmaIntensity), [
      JmaIntensity.three,
    ]);
    await notifier.updateRegion(
      slotId: initial.id,
      earthquakeOverrides: retained,
    );
    expect(
      repository.current.earthquakeOverrides?.map(
        (entry) => entry.minJmaIntensity,
      ),
      [JmaIntensity.three],
    );
    await expectLater(
      container.read(notificationSlotsProvider.future),
      throwsStateError,
    );
  });
}

class _Notifier extends NotificationSlotsNotifier {
  new(this.initial);
  final NotificationSlot initial;
  bool loaded = false;
  @override
  Future<List<NotificationSlot>> build() async {
    if (loaded) throw StateError('refetch failed');
    loaded = true;
    return [initial];
  }
}

class _Repository extends NotificationSlotRepository {
  new(this.current) : super(api: api.ApiClient(Dio()));
  NotificationSlot current;
  @override
  Future<NotificationSlot> updateRegion({
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
    current = current.copyWith(earthquakeOverrides: earthquakeOverrides);
    return current;
  }
}
