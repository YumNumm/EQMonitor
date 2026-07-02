import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

api.EewItemWithRelations _makeApiEew({
  String eventId = '20250101120000',
  api.TelegramStatus status = api.TelegramStatus.normal,
  api.InfoType infoType = api.InfoType.publication,
  num serialNo = 1,
  String? headline,
  bool isCanceled = false,
  bool? isWarning,
  bool isLastInfo = false,
  DateTime? originTime,
  DateTime? arrivalTime,
  api.EewAccuracy? accuracy,
  bool isPlum = false,
  String? editorialOffice,
  DateTime? reportTime,
  api.EewHypocenter? hypocenter,
  api.EewIntensity? forecastIntensity,
  api.EewWarning? warning,
}) {
  return api.EewItemWithRelations(
    eventId: eventId,
    type: api.TelegramType.vxse45,
    status: status,
    infoType: infoType,
    serialNo: serialNo,
    headline: headline,
    isCanceled: isCanceled,
    isWarning: isWarning,
    isLastInfo: isLastInfo,
    originTime: originTime,
    arrivalTime: arrivalTime,
    accuracy: accuracy,
    isPlum: isPlum,
    editorialOffice: editorialOffice,
    reportTime: reportTime ?? DateTime.utc(2025, 1, 1, 12),
    hypocenter: hypocenter,
    forecastIntensity: forecastIntensity,
    warning: warning,
  );
}

void main() {
  group('EewItemWithRelationsConverter.toEewTelegramItem', () {
    test('最小限のフィールドが正しく変換されること', () {
      final apiEew = _makeApiEew();
      final converted = apiEew.toEewTelegramItem;

      expect(converted.eventId, '20250101120000');
      expect(converted.status, TelegramStatus.normal);
      expect(converted.infoType, TelegramInfoType.publication);
      expect(converted.serialNo, 1);
      expect(converted.isCanceled, isFalse);
      expect(converted.isPlum, isFalse);
      expect(converted.isLastInfo, isFalse);
      expect(converted.headline, isNull);
      expect(converted.isWarning, isNull);
      expect(converted.hypocenter, isNull);
      expect(converted.forecastIntensity, isNull);
      expect(converted.warning, isNull);
      expect(converted.accuracy, isNull);
    });

    test('TelegramStatus / InfoType の変換が網羅的に行われること', () {
      for (final entry in <api.TelegramStatus, TelegramStatus>{
        api.TelegramStatus.normal: TelegramStatus.normal,
        api.TelegramStatus.training: TelegramStatus.training,
        api.TelegramStatus.test: TelegramStatus.test,
      }.entries) {
        final converted = _makeApiEew(status: entry.key).toEewTelegramItem;
        expect(converted.status, entry.value, reason: 'status ${entry.key}');
      }
      for (final entry in <api.InfoType, TelegramInfoType>{
        api.InfoType.publication: TelegramInfoType.publication,
        api.InfoType.correction: TelegramInfoType.correction,
        api.InfoType.cancellation: TelegramInfoType.cancellation,
      }.entries) {
        final converted = _makeApiEew(infoType: entry.key).toEewTelegramItem;
        expect(
          converted.infoType,
          entry.value,
          reason: 'infoType ${entry.key}',
        );
      }
    });

    test('hypocenter の code/name/magnitude/depth が引き渡ること', () {
      final apiEew = _makeApiEew(
        hypocenter: const api.EewHypocenter(
          code: '350',
          name: '岐阜県美濃中西部',
          coordinates: api.Coordinate(latitude: 35.5, longitude: 137.5),
          magnitude: 6.5,
          depth: 10,
        ),
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.hypocenter, isNotNull);
      expect(converted.hypocenter!.code, '350');
      expect(converted.hypocenter!.name, '岐阜県美濃中西部');
      expect(converted.hypocenter!.magnitude, 6.5);
      expect(converted.hypocenter!.depth, 10);
    });

    test('hypocenter の coordinates が設定済みのとき hasLatLng=true で値が引き渡る', () {
      final apiEew = _makeApiEew(
        hypocenter: const api.EewHypocenter(
          code: '350',
          name: '岐阜県美濃中西部',
          coordinates: api.Coordinate(latitude: 35.5, longitude: 137.5),
          magnitude: 5,
          depth: 30,
          detailed: api.CodeName(code: '350a', name: '美濃中西部詳細'),
        ),
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.hypocenter!.latitude, isNotNull);
      expect(converted.hypocenter!.longitude, isNotNull);
      expect(converted.hypocenter!.latitude, 35.5);
      expect(converted.hypocenter!.longitude, 137.5);
      expect(converted.hypocenter!.detailedCode, '350a');
      expect(converted.hypocenter!.detailedName, '美濃中西部詳細');
    });

    test('hypocenter の magnitude/depth が null でも例外にならず null で引き渡る', () {
      final apiEew = _makeApiEew(
        hypocenter: const api.EewHypocenter(
          code: '350',
          name: '岐阜県美濃中西部',
          coordinates: api.Coordinate(latitude: 35.5, longitude: 137.5),
          magnitude: null,
          depth: null,
        ),
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.hypocenter!.magnitude, isNull);
      expect(converted.hypocenter!.depth, isNull);
    });

    test('forecastIntensity の maxIntensity / isOver が引き渡ること', () {
      final apiEew = _makeApiEew(
        forecastIntensity: const api.EewIntensity(
          regions: [],
          maxIntensity: api.EewIntensityValue(
            value: api.JmaIntensity.value5plus,
            isOver: true,
          ),
        ),
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.forecastIntensity, isNotNull);
      expect(converted.forecastIntensity!.maxIntensity, JmaIntensity.fiveUpper);
      expect(converted.forecastIntensity!.maxIntensityIsOver, isTrue);
      expect(converted.forecastIntensity!.maxLpgmIntensity, isNull);
      expect(converted.forecastIntensity!.maxLpgmIntensityIsOver, isFalse);
      expect(converted.forecastIntensity!.regions, isEmpty);
    });

    test(
      'forecastIntensity.regions の arrivalTime.type=ARRIVED で isArrived=true',
      () {
        final apiEew = _makeApiEew(
          forecastIntensity: const api.EewIntensity(
            regions: [
              api.EewIntensityItem(
                code: '900',
                name: '岩手県',
                isPlum: false,
                isWarning: true,
                intensity: api.EewIntensityValue(
                  value: api.JmaIntensity.value5minus,
                  isOver: false,
                ),
                arrivalTime: api.EewIntensityRegionArrivalTimeTime(
                  type: api.EewIntensityRegionArrivalTimeType.arrived,
                ),
              ),
            ],
          ),
        );
        final region =
            apiEew.toEewTelegramItem.forecastIntensity!.regions.single;
        expect(region.code, '900');
        expect(region.name, '岩手県');
        expect(region.isWarning, isTrue);
        expect(region.intensity, JmaIntensity.fiveLower);
        expect(region.isArrived, isTrue);
        expect(region.arrivalTime, isNull);
      },
    );

    test(
      'forecastIntensity.regions の arrivalTime.type=TIME で arrivalTime が引き渡る',
      () {
        final t = DateTime.utc(2025, 1, 1, 12, 0, 30);
        final apiEew = _makeApiEew(
          forecastIntensity: api.EewIntensity(
            regions: [
              api.EewIntensityItem(
                code: '900',
                name: '岩手県',
                isPlum: false,
                isWarning: false,
                intensity: const api.EewIntensityValue(
                  value: api.JmaIntensity.value4,
                  isOver: false,
                ),
                arrivalTime: api.EewIntensityRegionArrivalTimeTime(
                  type: api.EewIntensityRegionArrivalTimeType.time,
                  value: t,
                ),
              ),
            ],
          ),
        );
        final region =
            apiEew.toEewTelegramItem.forecastIntensity!.regions.single;
        expect(region.arrivalTime, t);
        expect(region.isArrived, isFalse);
      },
    );

    test('warning の zones / prefectures / regions が変換されること', () {
      final apiEew = _makeApiEew(
        warning: const api.EewWarning(
          zones: [
            api.EewWarningZoneItem(
              code: '900',
              name: '岩手県',
              hadWarning: true,
            ),
          ],
          prefectures: [
            api.EewWarningZoneItem(
              code: '901',
              name: '宮城県',
              hadWarning: false,
            ),
          ],
          regions: [
            api.EewWarningZoneItem(
              code: '902',
              name: '東北地方',
              hadWarning: false,
            ),
          ],
        ),
      );
      final w = apiEew.toEewTelegramItem.warning!;
      expect(w.zones, hasLength(1));
      expect(w.zones.single.code, '900');
      expect(w.zones.single.hadWarning, isTrue);
      expect(w.prefectures, hasLength(1));
      expect(w.prefectures.single.name, '宮城県');
      expect(w.regions, hasLength(1));
      expect(w.regions.single.hadWarning, isFalse);
    });

    test('accuracy の num が int に変換されて引き渡ること', () {
      final apiEew = _makeApiEew(
        accuracy: const api.EewAccuracy(
          epicenter: 1,
          hypocenter: 2,
          depth: 3,
          magnitudeCalculation: 4,
          numberOfMagnitudeCalculation: 5,
        ),
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.accuracy, isNotNull);
      expect(converted.accuracy!.epicenter, 1);
      expect(converted.accuracy!.hypocenter, 2);
      expect(converted.accuracy!.depth, 3);
      expect(converted.accuracy!.magnitudeCalculation, 4);
      expect(converted.accuracy!.numberOfMagnitudeCalculation, 5);
    });

    test('serialNo が num でも int に変換されること', () {
      final apiEew = _makeApiEew(serialNo: 3.0);
      expect(apiEew.toEewTelegramItem.serialNo, 3);
    });

    test('originTime / arrivalTime / reportTime / editorialOffice が引き渡ること', () {
      final origin = DateTime.utc(2025, 1, 1, 12);
      final arrival = DateTime.utc(2025, 1, 1, 12, 0, 10);
      final report = DateTime.utc(2025, 1, 1, 12, 0, 20);
      final apiEew = _makeApiEew(
        originTime: origin,
        arrivalTime: arrival,
        reportTime: report,
        editorialOffice: '東京管区',
        headline: '震度4以上が予想されます',
        isWarning: true,
      );
      final converted = apiEew.toEewTelegramItem;
      expect(converted.originTime, origin);
      expect(converted.arrivalTime, arrival);
      expect(converted.reportTime, report);
      expect(converted.editorialOffice, '東京管区');
      expect(converted.headline, '震度4以上が予想されます');
      expect(converted.isWarning, isTrue);
    });
  });

  group('JmaLpgmIntensity 経由のチェック', () {
    test('maxLpgmIntensity が引き渡ること', () {
      final apiEew = _makeApiEew(
        forecastIntensity: const api.EewIntensity(
          regions: [],
          maxLpgmIntensity: api.EewIntensityLpgmValue(
            value: api.JmaLpgmIntensity.value3,
            isOver: true,
          ),
        ),
      );
      final f = apiEew.toEewTelegramItem.forecastIntensity!;
      expect(f.maxLpgmIntensity, JmaLpgmIntensity.three);
      expect(f.maxLpgmIntensityIsOver, isTrue);
    });
  });
}
