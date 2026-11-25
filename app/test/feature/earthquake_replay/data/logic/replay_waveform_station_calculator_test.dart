import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_geo_json_merger.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_record_assembler.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_station_calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';

void main() {
  // backend の earthquake-archiver と同じく、K-NET ASCII を観測点・成分ごとの 1005 にする。
  KyoshinWaveformReplayData frameOf(String extension) {
    final channel = const KnetAsciiParser().parse(
      File(
        '../packages/kyoshin_waveform/test/fixtures/EHM0012408081643.$extension',
      ).readAsStringSync(),
    );
    final bytes = ByteData(channel.counts.length * 4);
    for (var i = 0; i < channel.counts.length; i++) {
      bytes.setInt32(i * 4, channel.counts[i]);
    }
    return KyoshinWaveformReplayData(
      type: .kyoshinWaveform,
      time: channel.startTime,
      metadataJson: jsonEncode({
        'stationCode': channel.stationCode,
        'stationLatitude': channel.stationLatitude,
        'stationLongitude': channel.stationLongitude,
        'stationHeightMeters': channel.stationHeightMeters,
        'recordTime': channel.recordTime.toIso8601String(),
        'startTime': channel.startTime.toIso8601String(),
        'samplingHz': channel.samplingRate,
        'direction': channel.component.direction,
        'scaleNumeratorGal': 7845,
        'scaleDenominator': 8223790,
        'maxAccelerationGal': channel.maxAccelerationGal,
        'network': 'knet',
        'component': extension,
      }),
      samples: bytes.buffer.asUint8List(),
    );
  }

  group('ReplayWaveformStationCalculator', () {
    test('1005 のフレームから観測点ごとのリアルタイム震度を求めること', () {
      final stations = const ReplayWaveformStationCalculator(
        records: ReplayWaveformRecordAssembler(),
      ).calculateSync([frameOf('NS'), frameOf('EW'), frameOf('UD')]);

      expect(stations, hasLength(1));
      final station = stations.single;
      expect(station.stationCode, 'EHM001');
      expect(station.latitude, 33.9788);
      expect(
        station.intensities.startTime,
        DateTime.utc(2024, 8, 8, 7, 44, 15),
      );
      expect(station.intensities.interval, const Duration(milliseconds: 100));
      expect(station.intensities.values, hasLength(710));
      expect(station.intensities.maxValue, 1.6);
    });

    test('3成分がそろわない観測点は除くこと', () {
      final stations = const ReplayWaveformStationCalculator(
        records: ReplayWaveformRecordAssembler(),
      ).calculateSync([frameOf('NS'), frameOf('EW')]);

      expect(stations, isEmpty);
    });
  });

  group('ReplayWaveformGeoJsonMerger', () {
    const merger = ReplayWaveformGeoJsonMerger();
    Map<String, dynamic> feature(String name, double intensity) => {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [133.5, 33.9],
      },
      'properties': {'name': name, 'intensity': intensity},
    };
    Map<String, dynamic> lost(String name) => {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [133.5, 33.9],
      },
      'properties': {'lost': true, 'name': name},
    };

    test('波形の観測点がなければ画像の観測点をそのまま返すこと', () {
      final image = [feature('新居浜', 0.7)];

      expect(merger.merge(imageFeatures: image, waveformFeatures: []), image);
    });

    test('値のある波形の観測点は、同じ名前の画像の観測点を置き換えること', () {
      final merged = merger.merge(
        imageFeatures: [feature('伊予三島', 0.5), feature('新居浜', 0.7)],
        waveformFeatures: [feature('伊予三島', 1.6)],
      );

      expect(merged, [feature('新居浜', 0.7), feature('伊予三島', 1.6)]);
    });

    test('値の無い波形の観測点は、画像の観測点が無い場合だけ枠線で加えること', () {
      final merged = merger.merge(
        imageFeatures: [feature('伊予三島', 0.5)],
        waveformFeatures: [lost('伊予三島'), lost('今治')],
      );

      expect(merged, [feature('伊予三島', 0.5), lost('今治')]);
    });
  });
}
