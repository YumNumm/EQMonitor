import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
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
    test('sends fixed minimum intensity when enabling', () async {
      final slot = await repository.putCurrentLocation(
        eewEnabled: true,
        earthquakeEnabled: true,
      );

      expect(slot.slotType, NotificationSlotType.currentLocation);
      expect(slot.eewEnabled, isTrue);
      expect(adapter.lastRequestBody, isNotNull);
      expect(adapter.lastRequestBody!['eew_enabled'], isTrue);
      expect(adapter.lastRequestBody!['eew_min_intensity'], api.JmaIntensity.value4);
      expect(
        adapter.lastRequestBody!['earthquake_min_intensity'],
        api.JmaIntensity.value1,
      );
    });

    test('sends eew_enabled/earthquake_enabled=false when called without '
        'arguments', () async {
      await repository.putCurrentLocation();

      expect(adapter.lastRequestBody!['eew_enabled'], isFalse);
      expect(adapter.lastRequestBody!['earthquake_enabled'], isFalse);
      expect(
        adapter.lastRequestBody!.containsKey('eew_min_intensity'),
        isFalse,
      );
      expect(
        adapter.lastRequestBody!.containsKey('earthquake_min_intensity'),
        isFalse,
      );
    });
  });

  group('putNationwide', () {
    test('sends request and returns slot', () async {
      final slot = await repository.putNationwide(
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
      );

      expect(slot.slotType, NotificationSlotType.nationwide);
      expect(adapter.lastRequestBody!['eew_enabled'], isTrue);
    });

    test('sends eew_enabled/earthquake_enabled=false when called without '
        'arguments', () async {
      await repository.putNationwide();

      expect(adapter.lastRequestBody!['eew_enabled'], isFalse);
      expect(adapter.lastRequestBody!['earthquake_enabled'], isFalse);
      expect(
        adapter.lastRequestBody!.containsKey('eew_min_intensity'),
        isFalse,
      );
      expect(
        adapter.lastRequestBody!.containsKey('earthquake_min_intensity'),
        isFalse,
      );
    });
  });

  group('replaceSlots', () {
    test('sends the slot list and returns the parsed slots', () async {
      final slots = await repository.replaceSlots(const [
        NotificationSlotDraft(
          slotType: NotificationSlotType.currentLocation,
          eewEnabled: true,
          eewMinIntensity: JmaIntensity.four,
          earthquakeEnabled: true,
          earthquakeMinIntensity: JmaIntensity.one,
        ),
        NotificationSlotDraft(
          slotType: NotificationSlotType.nationwide,
          eewEnabled: true,
          eewMinIntensity: JmaIntensity.zero,
          earthquakeEnabled: true,
          earthquakeMinIntensity: JmaIntensity.zero,
        ),
      ]);

      expect(slots, hasLength(2));
      expect(adapter.lastRequestList, isNotNull);
      expect(adapter.lastRequestList, hasLength(2));
      final nationwide =
          adapter.lastRequestList!.cast<Map<String, dynamic>>().firstWhere(
            (e) => e['slot_type'] == api.SlotType.nationwide,
          );
      expect(nationwide['eew_min_intensity'], api.JmaIntensity.value0);
      expect(nationwide['earthquake_min_intensity'], api.JmaIntensity.value0);
    });

    test('sends an empty array to delete every slot', () async {
      await repository.replaceSlots(const []);
      expect(adapter.lastRequestList, isEmpty);
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

  group('updateRegion', () {
    test('sends default eew minimum intensity when enabling eew', () async {
      await repository.updateRegion(
        slotId: 'slot-123',
        eewEnabled: true,
        earthquakeEnabled: false,
      );

      expect(adapter.lastRequestBody!['eew_enabled'], isTrue);
      expect(
        adapter.lastRequestBody!['eew_min_intensity'],
        api.JmaIntensity.value3,
      );
      expect(adapter.lastRequestBody!['earthquake_enabled'], isFalse);
      expect(
        adapter.lastRequestBody!.containsKey('earthquake_min_intensity'),
        isFalse,
      );
    });

    test(
      'sends default earthquake minimum intensity when enabling earthquake',
      () async {
        await repository.updateRegion(
          slotId: 'slot-123',
          eewEnabled: false,
          earthquakeEnabled: true,
        );

        expect(adapter.lastRequestBody!['eew_enabled'], isFalse);
        expect(
          adapter.lastRequestBody!.containsKey('eew_min_intensity'),
          isFalse,
        );
        expect(adapter.lastRequestBody!['earthquake_enabled'], isTrue);
        expect(
          adapter.lastRequestBody!['earthquake_min_intensity'],
          api.JmaIntensity.value3,
        );
      },
    );
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

  group('patchEewGlobalSettings', () {
    test('sends warningEnabled as warning_enabled', () async {
      final settings = await repository.patchEewGlobalSettings(
        warningEnabled: false,
      );

      expect(settings.warningEnabled, isFalse);
      expect(adapter.lastRequestBody!['warning_enabled'], isFalse);
    });
  });
}

final class _SlotApiAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastRequestBody;
  List<dynamic>? lastRequestList;
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
    if (options.data is List) {
      lastRequestList = List<dynamic>.from(options.data as List);
    }

    if (path.endsWith('/slots') && method == 'PUT') {
      return _jsonResponse(jsonEncode(_slotsListResponse));
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

    if (path.endsWith('/nationwide') && (method == 'PUT' || method == 'GET')) {
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

    if (path.endsWith('/eew') && method == 'GET') {
      return _jsonResponse(jsonEncode(_eewGlobalResponseEnabled));
    }

    if (path.endsWith('/eew') && method == 'PATCH') {
      return _jsonResponse(jsonEncode(_eewGlobalResponseDisabled));
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

final Map<String, Object?> _currentLocationSlot = {
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

final Map<String, Object?> _regionSlot = {
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

final Map<String, Object?> _nationwideSlot = {
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

final List<Map<String, Object?>> _slotsListResponse = [
  _currentLocationSlot,
  _regionSlot,
];

const Map<String, String?> _eewWarningResponse = {
  'target': 'current_location_only',
  'nationwide_interruption_level': null,
};

const _eewWarningResponseNationwide = {
  'target': 'current_location_and_nationwide',
  'nationwide_interruption_level': 'active',
};

const Map<String, Object?> _eewGlobalResponseEnabled = {
  'enabled': true,
  'default_sound': 'default',
  'default_interruption_level': 'active',
  'start_live_activity': true,
  'collapse_notification': true,
  'warning_enabled': true,
};

const Map<String, Object?> _eewGlobalResponseDisabled = {
  'enabled': true,
  'default_sound': 'default',
  'default_interruption_level': 'active',
  'start_live_activity': true,
  'collapse_notification': true,
  'warning_enabled': false,
};
