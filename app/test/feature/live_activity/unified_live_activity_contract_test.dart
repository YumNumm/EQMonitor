import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fixtureDirectory = Directory('test/fixtures/live_activity/unified');

  Map<String, dynamic> fixture(String name) =>
      jsonDecode(File('${fixtureDirectory.path}/$name').readAsStringSync())
          as Map<String, dynamic>;

  test('canonical fixture decodes and re-encodes as a complete snapshot', () {
    final source = fixture('canonical.json');

    final state = UnifiedLiveActivityContentState.fromJson(source);
    final encoded = state.toJson();

    expect(state.schemaVersion, 2);
    expect(state.primary, UnifiedLiveActivityPrimary.earthquake);
    expect(state.shakeDetection?.level, ShakeDetectionLevel.stronger);
    expect(state.eew?.maxIntensity, JmaIntensity.sixLower);
    expect(
      state.eew?.location?.forecastLpgmIntensity,
      JmaLpgmIntensity.two,
    );
    expect(
      state.earthquake?.magnitude,
      const EarthquakeMagnitude.value(value: 6.8),
    );
    expect(
      encoded.keys,
      containsAll(<String>[
        'shakeDetection',
        'eew',
        'earthquake',
      ]),
    );
    expect(
      UnifiedLiveActivityContentState.fromJson(encoded),
      state,
    );
  });

  test('SHA-256 logical ID is accepted as an opaque non-empty ID', () {
    final source = fixture('sha256.json');
    final state = UnifiedLiveActivityContentState.fromJson(source);

    expect(state.id, source['id']);
    expect(state.id, isNotEmpty);
  });

  test('shared contract matrix has identical valid and invalid boundaries', () {
    final rows = jsonDecode(
      File('${fixtureDirectory.path}/matrix.json').readAsStringSync(),
    ) as List<dynamic>;

    for (final rawRow in rows) {
      final row = rawRow as Map<String, dynamic>;
      final name = row['name'] as String;
      final valid = row['valid'] as bool;
      final attributes = row['attributes'] as Map<String, dynamic>;
      final contentState = row['contentState'] as Map<String, dynamic>;

      if (valid) {
        final decodedAttributes = UnifiedLiveActivityAttributes.fromJson(
          attributes,
        );
        final decodedState = UnifiedLiveActivityContentState.fromJson(
          contentState,
        );
        expect(
          UnifiedLiveActivityAttributes.fromJson(decodedAttributes.toJson()),
          decodedAttributes,
          reason: name,
        );
        expect(
          UnifiedLiveActivityContentState.fromJson(decodedState.toJson()),
          decodedState,
          reason: name,
        );
      } else {
        expect(
          () {
            UnifiedLiveActivityAttributes.fromJson(attributes);
            UnifiedLiveActivityContentState.fromJson(contentState);
          },
          throwsA(isA<FormatException>()),
          reason: name,
        );
      }
    }
  });

  test(
    'required nullable keys stay explicit while optional EEW keys are omitted',
    () {
      final source = <String, dynamic>{
        'schemaVersion': 2,
        'id': 'logical-id',
        'updatedAt': '2026-09-11T03:38:00Z',
        'primary': 'eew',
        'shakeDetection': null,
        'eew': <String, dynamic>{
          'eventId': 'event',
          'headline': '',
          'hypocenterName': null,
          'magnitude': 0,
          'depth': 0,
          'time': null,
          'isOriginTime': false,
          'maxIntensity': null,
          'serialNo': 0,
          'isFinal': false,
          'isWarning': false,
          'isCanceled': false,
          'isPlum': false,
          'isLevel': false,
          'isOnePoint': false,
          'issuedAt': '2026-09-11T03:36:00Z',
          'location': <String, dynamic>{'regionName': ''},
        },
        'earthquake': null,
      };

      final encoded = UnifiedLiveActivityContentState.fromJson(source).toJson();
      final eew = encoded['eew'] as Map<String, dynamic>;
      final location = eew['location'] as Map<String, dynamic>;

      expect(encoded['shakeDetection'], isNull);
      expect(encoded['earthquake'], isNull);
      expect(eew['magnitude'], 0.0);
      expect(eew['depth'], 0.0);
      expect(eew, containsPair('time', null));
      expect(location.keys, <String>['regionName']);
    },
  );

  test('magnitude UNKNOWN differs from nullable magnitude and never emits runtimeType', () {
    final source = fixture('canonical.json');
    final earthquake = source['earthquake'] as Map<String, dynamic>;
    earthquake['magnitude'] = <String, dynamic>{'type': 'UNKNOWN'};

    final state = UnifiedLiveActivityContentState.fromJson(source);
    final encodedEarthquake =
        state.toJson()['earthquake'] as Map<String, dynamic>;

    expect(state.earthquake?.magnitude, const EarthquakeMagnitude.unknown());
    expect(encodedEarthquake['magnitude'], <String, dynamic>{
      'type': 'UNKNOWN',
    });
    expect(jsonEncode(encodedEarthquake), isNot(contains('runtimeType')));

    earthquake['magnitude'] = null;
    expect(
      UnifiedLiveActivityContentState.fromJson(source).earthquake?.magnitude,
      isNull,
    );
  });

  test('all wire enums preserve their exact strings', () {
    const intensityValues = <String>[
      '0',
      '1',
      '2',
      '3',
      '4',
      '!5-',
      '5-',
      '5+',
      '!6-',
      '6-',
      '6+',
      '7',
    ];
    const lpgmValues = <String>['0', '1', '2', '3', '4'];
    const shakeLevelValues = <String>[
      'Weaker',
      'Weak',
      'Medium',
      'Strong',
      'Stronger',
    ];
    expect(
      intensityValues.map(
        (value) => UnifiedLiveActivityWire.intensityToJson(
          UnifiedLiveActivityWire.intensityFromJson(value),
        ),
      ),
      intensityValues,
    );
    expect(
      lpgmValues.map(
        (value) => UnifiedLiveActivityWire.lpgmToJson(
          UnifiedLiveActivityWire.lpgmFromJson(value),
        ),
      ),
      lpgmValues,
    );
    expect(
      shakeLevelValues.map(
        (value) => UnifiedLiveActivityWire.shakeLevelToJson(
          UnifiedLiveActivityWire.shakeLevelFromJson(value),
        ),
      ),
      shakeLevelValues,
    );
    expect(
      UnifiedLiveActivityInformationType.values.map((value) => value.wireName),
      <String>['VXSE51', 'VXSE52', 'VXSE53', 'IXAC41'],
    );
  });

  test(
    'complete snapshot can explicitly remove a previously present block',
    () {
      final source = fixture('canonical.json');
      final initial = UnifiedLiveActivityContentState.fromJson(source);
      final nextJson = initial.toJson()
        ..['primary'] = 'earthquake'
        ..['shakeDetection'] = null
        ..['eew'] = null;

      final next = UnifiedLiveActivityContentState.fromJson(nextJson);

      expect(next.shakeDetection, isNull);
      expect(next.eew, isNull);
      expect(next.earthquake, isNotNull);
    },
  );

  test(
    'timestamps accept offset and fraction but reject normalization and junk',
    () {
      final source = fixture('canonical.json');
      source['updatedAt'] = '2026-09-11T12:38:00.123456+09:00';

      expect(
        UnifiedLiveActivityContentState.fromJson(source).updatedAt,
        DateTime.utc(2026, 9, 11, 3, 38, 0, 123, 456),
      );

      source['updatedAt'] = '2026-09-12T00:00:00.1234567Z';
      expect(
        UnifiedLiveActivityContentState.fromJson(source).updatedAt,
        DateTime.utc(2026, 9, 12, 0, 0, 0, 123, 456),
      );

      for (final invalid in <String>[
        '2026-02-30T09:00:00Z',
        '2026-09-12T09:00:00Zjunk',
      ]) {
        source['updatedAt'] = invalid;
        expect(
          () => UnifiedLiveActivityContentState.fromJson(source),
          throwsA(isA<FormatException>()),
          reason: invalid,
        );
      }
    },
  );
}
