import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _SlotApiAdapter adapter;
  late NotificationSlotRepository repository;

  setUp(() {
    adapter = _SlotApiAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    repository = NotificationSlotRepository(api.ApiClient(dio));
  });

  group('getSlots', () {
    test('returns list of NotificationSlot', () async {
      final slots = await repository.getSlots();

      expect(slots, hasLength(2));
      expect(slots[0].slotType, NotificationSlotType.currentLocation);
      expect(slots[0].eewEnabled, isTrue);
      expect(slots[0].eewMinIntensity, JmaIntensity.three);
      expect(slots[1].slotType, NotificationSlotType.region);
      expect(slots[1].regionId, 130000);
      expect(slots[1].regionName, '東京都');
    });
  });

  group('putCurrentLocation', () {
    test('sends request and returns slot', () async {
      final slot = await repository.putCurrentLocation(
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
      );

      expect(slot.slotType, NotificationSlotType.currentLocation);
      expect(slot.eewEnabled, isTrue);
      expect(adapter.lastRequestBody, isNotNull);
      expect(adapter.lastRequestBody!['eew_enabled'], isTrue);
    });
  });

  group('addRegion', () {
    test('sends create request with regionId', () async {
      final slot = await repository.addRegion(
        regionId: 270000,
        regionName: '大阪府',
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.three,
      );

      expect(slot.slotType, NotificationSlotType.region);
      expect(adapter.lastRequestBody!['region_id'], 270000);
      expect(adapter.lastRequestBody!['region_name'], '大阪府');
    });
  });

  group('removeRegion', () {
    test('sends delete request', () async {
      await repository.removeRegion(slotId: 'slot-123');
      expect(adapter.lastDeletedSlotId, 'slot-123');
    });
  });

  group('getEewWarningConfig', () {
    test('returns EewWarningSettings', () async {
      final settings = await repository.getEewWarningConfig();

      expect(settings.target, EewWarningTarget.currentLocationOnly);
      expect(settings.nationwideInterruptionLevel, isNull);
    });
  });

  group('patchEewWarningConfig', () {
    test('sends patch and returns updated settings', () async {
      final settings = await repository.patchEewWarningConfig(
        target: EewWarningTarget.currentLocationAndNationwide,
        nationwideInterruptionLevel: InterruptionLevel.active,
      );

      expect(
        settings.target,
        EewWarningTarget.currentLocationAndNationwide,
      );
      expect(settings.nationwideInterruptionLevel, InterruptionLevel.active);
    });
  });
}

final class _SlotApiAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastRequestBody;
  String? lastDeletedSlotId;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = options.path;
    final method = options.method;

    if (method == 'DELETE' && path.contains('/regions/')) {
      lastDeletedSlotId = path.split('/').last;
      return _jsonResponse('null', statusCode: 204);
    }

    if (options.data != null && options.data is Map<String, dynamic>) {
      lastRequestBody = Map<String, dynamic>.from(
        options.data as Map<String, dynamic>,
      );
    }

    if (path.endsWith('/slots') && method == 'GET') {
      return _jsonResponse(jsonEncode(_slotsListResponse));
    }

    if (path.endsWith('/current-location') &&
        (method == 'PUT' || method == 'GET')) {
      return _jsonResponse(jsonEncode(_currentLocationSlot));
    }

    if (path.endsWith('/current-location') && method == 'DELETE') {
      return _jsonResponse('null', statusCode: 204);
    }

    if (path.endsWith('/nationwide') &&
        (method == 'PUT' || method == 'GET')) {
      return _jsonResponse(jsonEncode(_nationwideSlot));
    }

    if (path.endsWith('/nationwide') && method == 'DELETE') {
      return _jsonResponse('null', statusCode: 204);
    }

    if (path.endsWith('/regions') && method == 'POST') {
      return _jsonResponse(jsonEncode(_regionSlot));
    }

    if (path.contains('/regions/') && method == 'PATCH') {
      return _jsonResponse(jsonEncode(_regionSlot));
    }

    if (path.endsWith('/eew-warning') && method == 'GET') {
      return _jsonResponse(jsonEncode(_eewWarningResponse));
    }

    if (path.endsWith('/eew-warning') && method == 'PATCH') {
      return _jsonResponse(
        jsonEncode(_eewWarningResponseNationwide),
      );
    }

    throw UnimplementedError('Unhandled: $method $path');
  }
}

ResponseBody _jsonResponse(String body, {int statusCode = 200}) =>
    ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        'content-type': ['application/json'],
      },
    );

final _currentLocationSlot = {
  'id': 'slot-cl',
  'slot_type': 'current_location',
  'region_id': null,
  'region_name': null,
  'city_code': null,
  'city_name': null,
  'display_order': 0,
  'eew_enabled': true,
  'eew_min_intensity': '3',
  'eew_overrides': null,
  'earthquake_enabled': true,
  'earthquake_min_intensity': '3',
  'earthquake_overrides': null,
  'created_at': '2026-06-30T00:00:00Z',
  'updated_at': '2026-06-30T00:00:00Z',
};

final _regionSlot = {
  'id': 'slot-region',
  'slot_type': 'region',
  'region_id': 130000,
  'region_name': '東京都',
  'city_code': null,
  'city_name': null,
  'display_order': 1,
  'eew_enabled': true,
  'eew_min_intensity': '4',
  'eew_overrides': null,
  'earthquake_enabled': true,
  'earthquake_min_intensity': '4',
  'earthquake_overrides': null,
  'created_at': '2026-06-30T00:00:00Z',
  'updated_at': '2026-06-30T00:00:00Z',
};

final _nationwideSlot = {
  'id': 'slot-nw',
  'slot_type': 'nationwide',
  'region_id': null,
  'region_name': null,
  'city_code': null,
  'city_name': null,
  'display_order': 2,
  'eew_enabled': true,
  'eew_min_intensity': '5-',
  'eew_overrides': [],
  'earthquake_enabled': true,
  'earthquake_min_intensity': '4',
  'earthquake_overrides': [],
  'created_at': '2026-06-30T00:00:00Z',
  'updated_at': '2026-06-30T00:00:00Z',
};

final _slotsListResponse = [_currentLocationSlot, _regionSlot];

const _eewWarningResponse = {
  'target': 'current_location_only',
  'nationwide_interruption_level': null,
};

const _eewWarningResponseNationwide = {
  'target': 'current_location_and_nationwide',
  'nationwide_interruption_level': 'active',
};
