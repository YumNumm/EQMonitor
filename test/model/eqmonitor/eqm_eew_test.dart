import 'dart:convert';
import 'dart:io';

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/model/eqmonitor/eqm_eew.dart';
import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

void main() {
  group('EqmEew', () {
    test('EqmEewのMessagePack Test1', () {
      final eew = EqmEew(
        eventId: 123456789,
        serialNo: 123456789,
        infoType: TelegramInfoType.announcement,
        status: TelegramStatus.normal,
        hypoName: 'hypoName',
        hypo: LatLng(35.123456, 135.123456),
        magnitude: 5.5,
        depth: 123,
        accuracy: EewAccuracy(
          depth: 1,
          epicenters: [1, 1],
          magnitudeCalculation: 1,
          numberOfMagnitudeCalculation: 1,
        ),
        isWarning: true,
        isLastInfo: true,
        isCanceled: true,
        depthCondition: EewDepthCondition.unknown,
        regions: [
          EewIntensityRegion(
            code: 100,
            forecastMaxInt: EewIntensityForecastMaxInt(
              from: JmaIntensity.int4,
              to: JmaIntensity.int5Lower,
            ),
            isPlum: true,
            isWarning: true,
            kind: EewIntensityKind(
              code: EarthquakeForecastCode.forecastArrived,
              name: EarthquakeForecastCode.forecastArrived.description,
            ),
            name: 'name',
            arrivalTime: DateTime.now(),
            forecastMaxLgInt: EewIntensityForecastMaxLgInt(
              from: JmaLgIntensity.int4,
              to: JmaLgIntensity.int4,
            ),
            condition: '既に主要動到達と推測',
          ),
        ],
      );

      final bytes = eew.toMessagePack();
      final eew2 = EqmEew.fromMessagePack(bytes);
      // gzip
      final bytesGzipBase64 = base64Encode(gzip.encode(bytes));
      print(bytesGzipBase64);
      print('Gzip Size: ${bytesGzipBase64.length} bytes');

      expect(eew.eventId, eew2.eventId);
      expect(eew.serialNo, eew2.serialNo);
      expect(eew.infoType, eew2.infoType);
      expect(eew.status, eew2.status);
      expect(eew.hypoName, eew2.hypoName);
      expect(eew.hypo, eew2.hypo);
      expect(eew.magnitude, eew2.magnitude);
      expect(eew.depth, eew2.depth);
      expect(eew.accuracy?.depth, eew2.accuracy?.depth);
      expect(eew.accuracy?.epicenters, eew2.accuracy?.epicenters);
      expect(
        eew.accuracy?.magnitudeCalculation,
        eew2.accuracy?.magnitudeCalculation,
      );
      expect(
        eew.accuracy?.numberOfMagnitudeCalculation,
        eew2.accuracy?.numberOfMagnitudeCalculation,
      );
      expect(eew.isWarning, eew2.isWarning);
      expect(eew.isLastInfo, eew2.isLastInfo);
    });

    test('EqmEewのMessagePack Test2', () async {
      const url = 'https://sample.dmdata.jp/eew/tech566/vxse45_1105_2.json';
      final res = await http.get(Uri.parse(url));

      final json = jsonDecode(utf8.decode(res.bodyBytes));
      final head = TelegramJsonMain.fromJson(json);
      final eewBody = EewInformation.fromJson(head.body);
      final eewTelegram = EewTelegram(head, eewBody);

      final eew = EqmEew.fromEew(eewTelegram);
      final bytes = eew.toMessagePackFcm();
      final eew2 = EqmEew.fromMessagePackFcm(bytes);
      final bytesGzipBase64 = base64Encode(gzip.encode(bytes));
      print(bytesGzipBase64);
      print('Gzip Size: ${bytesGzipBase64.length} bytes');

      expect(eew.eventId, eew2.eventId);
      expect(eew.serialNo, eew2.serialNo);
      expect(eew.infoType, eew2.infoType);
      expect(eew.status, eew2.status);
      expect(eew.hypoName, eew2.hypoName);
      expect(eew.hypo, eew2.hypo);
      expect(eew.magnitude, eew2.magnitude);
      expect(eew.depth, eew2.depth);
      expect(eew.accuracy?.depth, eew2.accuracy?.depth);
      expect(eew.accuracy?.epicenters, eew2.accuracy?.epicenters);
      expect(
        eew.accuracy?.magnitudeCalculation,
        eew2.accuracy?.magnitudeCalculation,
      );
      expect(
        eew.accuracy?.numberOfMagnitudeCalculation,
        eew2.accuracy?.numberOfMagnitudeCalculation,
      );
      expect(eew.isWarning, eew2.isWarning);
      expect(eew.isLastInfo, eew2.isLastInfo);
      for (final region in eew.regions) {
        final region2 =
            eew2.regions.firstWhere((element) => element.code == region.code);
        expect(region.code, region2.code);
        expect(region.forecastMaxInt.from, region2.forecastMaxInt.from);
        expect(region.forecastMaxInt.to, region2.forecastMaxInt.to);
        expect(region.isPlum, region2.isPlum);
        expect(region.isWarning, region2.isWarning);
        expect(region.name, region2.name);
        expect(region.forecastMaxLgInt?.from, region2.forecastMaxLgInt?.from);
        expect(region.forecastMaxLgInt?.to, region2.forecastMaxLgInt?.to);
      }
    });
  });
}
