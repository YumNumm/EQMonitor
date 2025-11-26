import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:test/test.dart';

void main() {
  final azarashi = DartAzarashi();

  group('scenario1 - 緊急地震速報、震度、震源、津波', () {
    test('緊急地震速報', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAF899C80000324000039000548C5E2C000000003DFF8001C000012FE4B0FC*7F',
      );
      expect(report, isA<QzssDcReportEarthquakeEarlyWarning>());
    });

    test('震度', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AF999C828001C82CB25AE775A8D4CA854AB8000000000000000011E027E5C*76',
      );
      expect(report, isA<QzssDcReportSeismicIntensity>());
    });

    test('震源', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAF919C82800388000039051440C5C82A0108300000000000000012497DA18*0A',
      );
      expect(report, isA<QzssDcReportHypocenter>());
    });

    test('津波', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAFA99C828001E8F67C31053960414E621053BE00000000000000132735038*0F',
      );
      expect(report, isA<QzssDcReportTsunami>());
    });
  });

  group('scenario2 - 津波(更新)', () {
    test('津波(更新)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAFA99C8C8001E8F67C31193960464E621193BBC464EF80000000109DB7028*09',
      );
      expect(report, isA<QzssDcReportTsunami>());
    });
  });

  group('hex decoder', () {
    test('Hexadecimal decode', () {
      final report = azarashi.hexDecoder.decode(
        'C6AF89A820000324000050400548C5E2C000000003DFF8001C00001185443FC',
      );
      expect(report, isA<QzssDcReportEarthquakeEarlyWarning>());
    });
  });

  group('unknown magnitude or depth', () {
    test('震源 マグニチュード:不明, 深さ:不明', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,55,53AD160D2800039400001A28FFFFEE601800C8F00000000000000011BF8D908*01',
      );
      expect(report, isA<QzssDcReportHypocenter>());
      final hypocenter = report as QzssDcReportHypocenter;
      expect(hypocenter.depthOfHypocenter, '不明');
      expect(hypocenter.depthOfHypocenterRaw, 511);
      expect(hypocenter.magnitude, '不明');
      expect(hypocenter.magnitudeRaw, 127);
    });
  });

  group('long period ground motion', () {
    test('緊急地震速報 長周期地震動', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,56,9AAF88A48000DB24000049000548C5E2C000000003DFF8001C000012101445C*7B',
      );
      expect(report, isA<QzssDcReportEarthquakeEarlyWarning>());
      final eew = report as QzssDcReportEarthquakeEarlyWarning;
      expect(eew.longPeriodGroundMotionLowerLimit, '長周期地震動階級2');
      expect(eew.longPeriodGroundMotionLowerLimitRaw, 3);
      expect(eew.longPeriodGroundMotionUpperLimit, '長周期地震動階級2');
      expect(eew.longPeriodGroundMotionUpperLimitRaw, 3);
    });
  });

  group('DCX messages', () {
    test('DCX Null Message', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,55,53B0840DE0000000000000000000000000000000000000000000000012ACBD4*0E',
      );
      expect(report, isA<QzssDcReportDcxNull>());
    });

    test('DCX Outside Japan', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,56,9AB08408E0598969E00066AFFE8E6F70091200000000000000000100CD1A410*0C',
      );
      expect(report, isA<QzssDcReportDcxOutsideJapan>());
    });

    test('DCX L-Alert', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,55,9AB0840DE10208ADE0000000000000000000011340000000000000132F0D238*04',
      );
      expect(report, isA<QzssDcReportDcxLAlert>());
    });

    test('DCX J-Alert', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,55,53B0840DE31188FC208600000000000000001FFFFFFFFFFFC00000120738628*00',
      );
      expect(report, isA<QzssDcReportDcxJAlert>());
    });
  });

  group('decode error', () {
    test('CRC mismatch (hex)', () {
      expect(
        () => azarashi.hexDecoder.decode(
          'C6AF89A820000324000050400548C5E2C000000003DFF8001C000011854432D',
        ),
        throwsA(isA<QzssDcrDecoderException>()),
      );
    });

    test('Checksum mismatch (nmea)', () {
      expect(
        () => azarashi.nmeaDecoder.decode(
          r'$QZQSM,55,C6AF89A820000324000050400548C5E2C000000003DFF8001C00001185443FC*00',
        ),
        throwsA(isA<QzssDcrDecoderException>()),
      );
    });
  });

  group('scenario3 - 南海トラフ地震', () {
    test('南海トラフ地震', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFA19C918002F2C6CBF35ADBF1C1C471C1D4F1C1CAF3595F82D81262EF438*02',
      );
      expect(report, isA<QzssDcReportNankaiTroughEarthquake>());
    });

    test('南海トラフ地震 (最終ページ)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAFA19C918002F1C0C271C04100000000000000000000000036D81121AA2D0*07',
      );
      expect(report, isA<QzssDcReportNankaiTroughEarthquake>());
    });
  });

  group('scenario4 - 火山, 降灰', () {
    test('火山', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFC19CA50001CA5341F783E0F10910421230200000000000000011B086438*70',
      );
      expect(report, isA<QzssDcReportVolcano>());
    });

    test('降灰(速報)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAFC99CA50001CA523EE4C1F07826122081309181000000000000121BAF1C0*71',
      );
      expect(report, isA<QzssDcReportAshFall>());
    });
  });

  group('scenario5 - 降灰(詳細)', () {
    test('降灰(詳細)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFC99CAA0001CAA43EE541F0782A1220813091811183E0F000001329B16E0*7F',
      );
      expect(report, isA<QzssDcReportAshFall>());
    });
  });

  group('scenario6 - 気象, 洪水', () {
    test('気象', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFD19CB18001113880115F901186A011ADB011D4C011FBD00000135EAA3F8*73',
      );
      expect(report, isA<QzssDcReportWeather>());
    });

    test('洪水', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFD99CB1800160A8F5528600000000000000000000000000000010E502538*0E',
      );
      expect(report, isA<QzssDcReportFlood>());
    });
  });

  group('scenario7 - 洪水(警報解除)', () {
    test('洪水(警報解除)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFD99CB90000E0A8F5528600000000000000000000000000000013A699D5C*76',
      );
      expect(report, isA<QzssDcReportFlood>());
    });
  });

  group('北西太平洋津波', () {
    test('北西太平洋津波 (1)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,55,53AD360D5B80047FFFFE3000000000000000000000000000000000118372EC8*0C',
      );
      expect(report, isA<QzssDcReportNorthwestPacificTsunami>());
    });

    test('北西太平洋津波 (2)', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,56,9AAD3609E080023AE008D3D1008E449009D457009E3E5011F00000138B3E720*09',
      );
      expect(report, isA<QzssDcReportNorthwestPacificTsunami>());
    });
  });

  group('toJson/fromJson', () {
    test('EarthquakeEarlyWarning toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAF899C80000324000039000548C5E2C000000003DFF8001C000012FE4B0FC*7F',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportEarthquakeEarlyWarning>());
      expect(restored.toJson(), equals(json));
    });

    test('Hypocenter toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAF919C82800388000039051440C5C82A0108300000000000000012497DA18*0A',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportHypocenter>());
      expect(restored.toJson(), equals(json));
    });

    test('NankaiTroughEarthquake toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFA19C918002F2C6CBF35ADBF1C1C471C1D4F1C1CAF3595F82D81262EF438*02',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportNankaiTroughEarthquake>());
      expect(restored.toJson(), equals(json));
    });

    test('Volcano toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFC19CA50001CA5341F783E0F10910421230200000000000000011B086438*70',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportVolcano>());
      expect(restored.toJson(), equals(json));
    });

    test('AshFall toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,9AAFC99CA50001CA523EE4C1F07826122081309181000000000000121BAF1C0*71',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportAshFall>());
      expect(restored.toJson(), equals(json));
    });

    test('Weather toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFD19CB18001113880115F901186A011ADB011D4C011FBD00000135EAA3F8*73',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportWeather>());
      expect(restored.toJson(), equals(json));
    });

    test('Flood toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,58,C6AFD99CB1800160A8F5528600000000000000000000000000000010E502538*0E',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportFlood>());
      expect(restored.toJson(), equals(json));
    });

    test('NorthwestPacificTsunami toJson/fromJson', () {
      final report = azarashi.nmeaDecoder.decode(
        r'$QZQSM,56,9AAD3609E080023AE008D3D1008E449009D457009E3E5011F00000138B3E720*09',
      );
      final json = report.toJson();
      final restored = QzssDcReport.fromJson(json);
      expect(restored, isA<QzssDcReportNorthwestPacificTsunami>());
      expect(restored.toJson(), equals(json));
    });
  });
}
