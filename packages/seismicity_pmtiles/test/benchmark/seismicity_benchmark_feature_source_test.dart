import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../benchmark/support/seismicity_benchmark_feature_source.dart';

void main() {
  const source = SeismicityBenchmarkFeatureSource();

  test('derives first middle and last features deterministically', () {
    final first = source.featureAt(index: 0);
    final middle = source.featureAt(index: 1_000_000);
    final last = source.featureAt(index: 1_999_999);

    for (final feature in [first, middle, last]) {
      expect(feature.hypocenterId, Uuid.parse(feature.hypocenterIdText));
      expect(feature.hypocenterId[6] & 0xf0, 0x40);
      expect(feature.hypocenterId[8] & 0xc0, 0x80);
      expect(feature.earthquakeEventIdUtf8, isNotEmpty);
      expect(
        utf8.decode(feature.earthquakeEventIdUtf8),
        'E${feature.index}',
      );
      expect(
        feature.expectedPublicBytes,
        SeismicityBenchmarkFeatureSource.fixedPublicBytesPerRow +
            (feature.maxIntensityUtf8?.lengthInBytes ?? 0),
      );
      expect(feature.longitude.isFinite, isTrue);
      expect(feature.latitude.isFinite, isTrue);
    }

    expect(first.magnitude, 0.0);
    expect(first.depthKm, 0.0);
    expect(first.maxIntensityUtf8, utf8.encode('I0'));
    expect(first.determinationFlagUtf8, utf8.encode('D0'));
    expect(first.geometryClamped, isFalse);

    expect(middle.magnitude, 1_000_000 * 0.01);
    expect(middle.depthKm, isNull);
    expect(middle.maxIntensityUtf8, utf8.encode('I1000000'));
    expect(middle.determinationFlagUtf8, isNull);
    expect(middle.geometryClamped, isFalse);

    expect(last.magnitude, isNull);
    expect(last.depthKm, isNull);
    expect(last.maxIntensityUtf8, utf8.encode('I1999999'));
    expect(last.determinationFlagUtf8, isNull);
    expect(last.geometryClamped, isNull);

    expect(source.featureAt(index: 0).hypocenterIdText, first.hypocenterIdText);
    expect(
      () => source.featureAt(index: -1),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('presence pattern covers empty and absent optional strings', () {
    final absentIntensity = source.featureAt(index: 1);
    final emptyIntensity = source.featureAt(index: 2);
    final absentDetermination = source.featureAt(index: 1);
    final emptyDetermination = source.featureAt(index: 2);

    expect(absentIntensity.maxIntensityUtf8, isNull);
    expect(emptyIntensity.maxIntensityUtf8, isEmpty);
    expect(absentDetermination.determinationFlagUtf8, isNull);
    expect(emptyDetermination.determinationFlagUtf8, isEmpty);
    expect(emptyIntensity.expectedPublicBytes, 52);
    expect(
      absentIntensity.expectedPublicBytes,
      SeismicityBenchmarkFeatureSource.fixedPublicBytesPerRow,
    );
  });
}
