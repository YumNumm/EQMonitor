import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/location/data/headless/headless_device_location_runner.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeadlessDeviceLocationRunner.run', () {
    test('送信成功後にdeviceLocationをackしてactive taskを成功完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'pending-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(),
      );

      final result = await runner.run(taskUpdateId: 'active-1');

      expect(result, HeadlessTaskResult.success);
      expect(bridge.events, [
        'ack:pending-1:deviceLocation',
        'complete:active-1:success',
      ]);
      expect(bridge.completionCount, 1);
    });

    test('前回送信値と同じ場合もdeviceLocationをackして成功完了する', () async {
      const payload = DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      );
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'same-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(lastSent: payload),
      );

      final result = await runner.run(taskUpdateId: 'active-same');

      expect(result, HeadlessTaskResult.success);
      expect(bridge.events, [
        'ack:same-1:deviceLocation',
        'complete:active-same:success',
      ]);
    });

    test('Device Locationが無効な場合は送信せずackして成功完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'disabled-1'),
      );
      var sentCount = 0;
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(
          availability: DeviceLocationSyncAvailability.disabled,
          onSend: () => sentCount++,
        ),
      );

      final result = await runner.run(taskUpdateId: 'active-disabled');

      expect(result, HeadlessTaskResult.success);
      expect(sentCount, 0);
      expect(bridge.events, [
        'ack:disabled-1:deviceLocation',
        'complete:active-disabled:success',
      ]);
    });

    test('pendingなしでもactive taskを成功完了してserviceを構築しない', () async {
      final bridge = RecordingBackgroundLocationBridge(pending: null);
      var createCount = 0;
      final runner = HeadlessDeviceLocationRunner(
        bridge: bridge,
        createSyncService: () async {
          createCount++;
          return createSyncService();
        },
      );

      final result = await runner.run(taskUpdateId: 'active-empty');

      expect(result, HeadlessTaskResult.success);
      expect(createCount, 0);
      expect(bridge.events, ['complete:active-empty:success']);
      expect(bridge.completionCount, 1);
    });

    test('送信可否が未初期化ならretryで完了してpendingを保持する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'uninitialized-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(
          availability: DeviceLocationSyncAvailability.uninitialized,
        ),
      );

      final result = await runner.run(taskUpdateId: 'active-uninitialized');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-uninitialized:retry']);
    });

    test('地域解決失敗時はretryで完了してpendingを保持する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'resolve-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(resolvePayload: () => null),
      );

      final result = await runner.run(taskUpdateId: 'active-resolve');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-resolve:retry']);
    });

    test('同期state読み取り失敗時はretryで完了してpendingを保持する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'state-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(
          stateRepository: ThrowingDeviceLocationSyncStateRepository(),
        ),
      );

      final result = await runner.run(taskUpdateId: 'active-state');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-state:retry']);
      expect(bridge.completionCount, 1);
    });

    for (final statusCode in [401, 403, 408, 409, 425, 429, 500, 503]) {
      test('HTTP $statusCodeはretryで完了してpendingを保持する', () async {
        final bridge = RecordingBackgroundLocationBridge(
          pending: pendingLocation(updateId: 'http-$statusCode'),
        );
        final runner = createRunner(
          bridge: bridge,
          service: createSyncService(
            sendError: dioStatusError(statusCode),
          ),
        );

        final result = await runner.run(taskUpdateId: 'active-$statusCode');

        expect(result, HeadlessTaskResult.retry);
        expect(bridge.events, ['complete:active-$statusCode:retry']);
      });
    }

    test('HTTP 404はdevice not foundのため診断・ackせずretryで完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'http-404'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(sendError: dioStatusError(404)),
        recordTerminalFailure:
            ({required updateId, required statusCode}) async {
              bridge.events.add('diagnostic:$updateId:$statusCode');
            },
      );

      final result = await runner.run(taskUpdateId: 'active-404');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-404:retry']);
      expect(bridge.completionCount, 1);
    });

    test('API契約にないHTTP 422は診断・ackせずretryで完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'http-422'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(sendError: dioStatusError(422)),
        recordTerminalFailure:
            ({required updateId, required statusCode}) async {
              bridge.events.add('diagnostic:$updateId:$statusCode');
            },
      );

      final result = await runner.run(taskUpdateId: 'active-422');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-422:retry']);
      expect(bridge.completionCount, 1);
    });

    test('ネットワーク失敗時はretryで完了してpendingを保持する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'network-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(sendError: dioNetworkError()),
      );

      final result = await runner.run(taskUpdateId: 'active-network');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, ['complete:active-network:retry']);
    });

    test('API契約上Bad Requestの400は診断保存後にackしてterminalFailureで完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'invalid-1'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(sendError: dioStatusError(400)),
        recordTerminalFailure:
            ({required updateId, required statusCode}) async {
              bridge.events.add('diagnostic:$updateId:$statusCode');
            },
      );

      final result = await runner.run(taskUpdateId: 'active-invalid');

      expect(result, HeadlessTaskResult.terminalFailure);
      expect(bridge.events, [
        'diagnostic:invalid-1:400',
        'ack:invalid-1:deviceLocation',
        'complete:active-invalid:terminalFailure',
      ]);
      expect(bridge.completionCount, 1);
    });

    test('terminal診断の保存失敗時はretryに戻してpendingを保持する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'diagnostic-failure'),
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(sendError: dioStatusError(400)),
        recordTerminalFailure:
            ({required updateId, required statusCode}) async {
              throw StateError('diagnostic storage unavailable');
            },
      );

      final result = await runner.run(
        taskUpdateId: 'active-diagnostic-failure',
      );

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, [
        'complete:active-diagnostic-failure:retry',
      ]);
    });

    test('ack失敗時はretryに戻しactive taskを一度だけ完了する', () async {
      final bridge = RecordingBackgroundLocationBridge(
        pending: pendingLocation(updateId: 'ack-failure'),
        acknowledgeResult: false,
      );
      final runner = createRunner(
        bridge: bridge,
        service: createSyncService(),
      );

      final result = await runner.run(taskUpdateId: 'active-ack-failure');

      expect(result, HeadlessTaskResult.retry);
      expect(bridge.events, [
        'ack:ack-failure:deviceLocation',
        'complete:active-ack-failure:retry',
      ]);
      expect(bridge.completionCount, 1);
    });
  });
}

HeadlessDeviceLocationRunner createRunner({
  required RecordingBackgroundLocationBridge bridge,
  required DeviceLocationSyncService service,
  RecordHeadlessTerminalFailure? recordTerminalFailure,
}) => HeadlessDeviceLocationRunner(
  bridge: bridge,
  createSyncService: () async => service,
  recordTerminalFailure: recordTerminalFailure,
);

DeviceLocationSyncService createSyncService({
  DeviceLocationSyncAvailability availability =
      DeviceLocationSyncAvailability.enabled,
  DeviceLocationSyncStateRepository? stateRepository,
  DeviceLocationPayload? lastSent,
  DeviceLocationPayload? Function()? resolvePayload,
  Object? sendError,
  void Function()? onSend,
}) => DeviceLocationSyncService(
  stateRepository:
      stateRepository ??
      InMemoryDeviceLocationSyncStateRepository(
        availability: availability,
        lastSent: lastSent,
      ),
  resolvePayload: ({required latitude, required longitude}) async {
    if (resolvePayload != null) {
      return resolvePayload();
    }
    return const DeviceLocationPayload(
      region: '301',
      city: '0820100',
      tsunamiForecastRegion: '201',
    );
  },
  sendPayload: ({required payload}) async {
    onSend?.call();
    if (sendError case final error?) {
      throw error;
    }
  },
);

PendingLocationMessage pendingLocation({required String updateId}) =>
    PendingLocationMessage(
      updateId: updateId,
      latitude: 36,
      longitude: 140,
      accuracy: 10,
      timestampMillis: 1000,
    );

DioException dioStatusError(int statusCode) {
  final options = RequestOptions(path: '/v2/device/me/location');
  return DioException(
    requestOptions: options,
    response: Response<void>(requestOptions: options, statusCode: statusCode),
    type: DioExceptionType.badResponse,
  );
}

DioException dioNetworkError() => DioException(
  requestOptions: RequestOptions(path: '/v2/device/me/location'),
  type: DioExceptionType.connectionError,
);

class ThrowingDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  @override
  Future<DeviceLocationSyncAvailability> readAvailability() =>
      Future.error(StateError('state storage unavailable'));

  @override
  Future<DeviceLocationPayload?> readLastSent() => throw UnimplementedError();

  @override
  Future<void> writeAvailability(
    DeviceLocationSyncAvailability availability,
  ) => throw UnimplementedError();

  @override
  Future<void> writeLastSent(DeviceLocationPayload payload) =>
      throw UnimplementedError();
}

class RecordingBackgroundLocationBridge
    implements HeadlessBackgroundLocationBridge {
  new({
    required this.pending,
    this.acknowledgeResult = true,
  });

  final PendingLocationMessage? pending;
  final bool acknowledgeResult;
  final events = <String>[];
  var completionCount = 0;

  @override
  Future<bool> acknowledgePendingLocation({
    required String updateId,
    required PendingLocationConsumer consumer,
  }) async {
    events.add('ack:$updateId:${consumer.name}');
    return acknowledgeResult;
  }

  @override
  Future<void> completeHeadlessTask({
    required String updateId,
    required HeadlessTaskResult result,
  }) async {
    completionCount++;
    events.add('complete:$updateId:${result.name}');
  }

  @override
  Future<PendingLocationMessage?> peekPendingLocation({
    required PendingLocationConsumer consumer,
  }) async {
    expect(consumer, PendingLocationConsumer.deviceLocation);
    return pending;
  }
}
