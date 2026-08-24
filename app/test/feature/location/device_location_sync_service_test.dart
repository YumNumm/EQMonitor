import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceLocationPayload.toJson', () {
    test('3つの地域コードをAPIのキー名で返す', () {
      expect(
        const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ).toJson(),
        {
          'region': '301',
          'city': '0820100',
          'tsunamiForecastRegion': '201',
        },
      );
    });

    test('nullableな地域コードは送信payloadから省略する', () {
      expect(
        const DeviceLocationPayload(
          region: '301',
          city: null,
          tsunamiForecastRegion: null,
        ).toJson(),
        {'region': '301'},
      );
    });
  });

  group('DeviceLocationSyncService.syncPending', () {
    test('registration generation変更後は同じ地域payloadでも送信する', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: oldScope,
        lastSent: const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ),
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '301',
              city: '0820100',
              tsunamiForecastRegion: '201',
            ),
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.sent);
      expect(sent, hasLength(1));
      expect(await state.readLastSent(scope: currentScope), sent.single);
    });

    test('cityだけが前回成功値と異なる場合に新payloadを送信する', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ),
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '301',
              city: '0820200',
              tsunamiForecastRegion: '201',
            ),
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.sent);
      expect(sent.single.city, '0820200');
      expect(await state.readLastSent(scope: currentScope), sent.single);
    });

    test('regionだけが前回成功値と異なる場合に新payloadを送信する', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ),
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '302',
              city: '0820100',
              tsunamiForecastRegion: '201',
            ),
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.sent);
      expect(sent.single.toJson(), {
        'region': '302',
        'city': '0820100',
        'tsunamiForecastRegion': '201',
      });
      expect((await state.readLastSent(scope: currentScope))?.toJson(), {
        'region': '302',
        'city': '0820100',
        'tsunamiForecastRegion': '201',
      });
    });

    test('tsunamiForecastRegionだけが前回成功値と異なる場合に新payloadを送信する', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ),
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '301',
              city: '0820100',
              tsunamiForecastRegion: '202',
            ),
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.sent);
      expect(sent.single.toJson(), {
        'region': '301',
        'city': '0820100',
        'tsunamiForecastRegion': '202',
      });
      expect((await state.readLastSent(scope: currentScope))?.toJson(), {
        'region': '301',
        'city': '0820100',
        'tsunamiForecastRegion': '202',
      });
    });

    test('3項目が前回成功値と同じ場合は送信しない', () async {
      final previous = const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      );
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: previous,
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '301',
              city: '0820100',
              tsunamiForecastRegion: '201',
            ),
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.unchanged);
      expect(sent, isEmpty);
      expect(await state.readLastSent(scope: currentScope), same(previous));
    });

    test('地域を解決できない場合は例外を投げて送信しない', () async {
      final previous = const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      );
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: previous,
      );
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async => null,
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      await expectLater(
        service.syncPending(location: pendingLocation),
        throwsStateError,
      );

      expect(sent, isEmpty);
      expect(await state.readLastSent(scope: currentScope), same(previous));
    });

    test('APIが例外を投げた場合は最後の送信成功値を更新しない', () async {
      final previous = const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      );
      final state = InMemoryDeviceLocationSyncStateRepository(
        lastSentScope: currentScope,
        lastSent: previous,
      );
      final attempted = <DeviceLocationPayload>[];
      final error = Exception('api failure');
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async =>
            const DeviceLocationPayload(
              region: '302',
              city: '0820100',
              tsunamiForecastRegion: '201',
            ),
        sendPayload: ({required payload}) async {
          attempted.add(payload);
          throw error;
        },
      );

      await expectLater(
        service.syncPending(location: pendingLocation),
        throwsA(same(error)),
      );

      expect(attempted.single.toJson(), {
        'region': '302',
        'city': '0820100',
        'tsunamiForecastRegion': '201',
      });
      expect(await state.readLastSent(scope: currentScope), same(previous));
    });

    test('同期が無効な場合は地域解決も送信も行わない', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        availability: DeviceLocationSyncAvailability.disabled,
      );
      var resolutionCount = 0;
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async {
          resolutionCount++;
          return const DeviceLocationPayload(
            region: '301',
            city: '0820100',
            tsunamiForecastRegion: '201',
          );
        },
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.disabled);
      expect(resolutionCount, 0);
      expect(sent, isEmpty);
      expect(await state.readLastSent(scope: currentScope), isNull);
    });

    test('同期可否が未初期化なら送信せず明示的に返す', () async {
      final state = InMemoryDeviceLocationSyncStateRepository(
        availability: DeviceLocationSyncAvailability.uninitialized,
      );
      var resolutionCount = 0;
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async {
          resolutionCount++;
          return const DeviceLocationPayload(
            region: '301',
            city: '0820100',
            tsunamiForecastRegion: '201',
          );
        },
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: pendingLocation);

      expect(result, DeviceLocationSyncResult.uninitialized);
      expect(resolutionCount, 0);
      expect(sent, isEmpty);
      expect(await state.readLastSent(scope: currentScope), isNull);
    });

    test('pending位置がない場合は地域解決も送信も行わない', () async {
      final state = InMemoryDeviceLocationSyncStateRepository();
      var resolutionCount = 0;
      final sent = <DeviceLocationPayload>[];
      final service = DeviceLocationSyncService(
        scope: currentScope,
        stateRepository: state,
        resolvePayload: ({required latitude, required longitude}) async {
          resolutionCount++;
          return const DeviceLocationPayload(
            region: '301',
            city: '0820100',
            tsunamiForecastRegion: '201',
          );
        },
        sendPayload: ({required payload}) async => sent.add(payload),
      );

      final result = await service.syncPending(location: null);

      expect(result, DeviceLocationSyncResult.noPending);
      expect(resolutionCount, 0);
      expect(sent, isEmpty);
      expect(await state.readLastSent(scope: currentScope), isNull);
    });
  });
}

const pendingLocation = PendingDeviceLocation(
  updateId: 'u1',
  latitude: 36,
  longitude: 140,
  accuracy: 10,
  timestampMillis: 1000,
);

const currentScope = DeviceLocationSyncScope(
  apiEndpoint: 'https://api.example.com/v2/device/me/location',
);

const oldScope = DeviceLocationSyncScope(
  apiEndpoint: 'https://old-api.example.com/v2/device/me/location',
);
