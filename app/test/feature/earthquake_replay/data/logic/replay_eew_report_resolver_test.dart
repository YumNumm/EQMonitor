import 'dart:convert';
import 'dart:io';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_eew_report_resolver.dart';
import 'package:eqmonitor/feature/eew/data/converter/jma_eew_xml_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _fixtures = '../packages/jma_eew_xml/test/fixtures';

JmaXmlTelegramReplayData _xmlFrame(String name, {required String title}) =>
    JmaXmlTelegramReplayData(
      type: .jmaXmlTelegram,
      time: DateTime.utc(2024, 4, 17, 14, 15),
      title: title,
      telegram: File('$_fixtures/$name').readAsStringSync(),
    );

void main() {
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
  const resolver = ReplayEewReportResolver(
    jmaEewXmlConverter: JmaEewXmlConverter(),
  );
  const forecastTitle = '緊急地震速報（地震動予報）';
  const warningTitle = '緊急地震速報（警報）';

  test('気象庁 XML の緊急地震速報をアプリ用のモデルにすること', () {
    final reports = resolver.resolve([
      _xmlFrame('77_01_05_240613_VXSE45.xml', title: forecastTitle),
    ]);

    final eew = reports[0]!;
    expect(eew.eventId, '20240417231454');
    expect(eew.serialNo, 5);
    expect(eew.isCanceled, isFalse);
    expect(eew.isWarning, isTrue);
    expect(eew.isPlum, isFalse);
    expect(eew.headline, '豊後水道で地震　四国　九州　中国で強い揺れ');
    expect(eew.originTime, DateTime.utc(2024, 4, 17, 14, 14, 47));
    expect(eew.hypocenter?.name, '豊後水道');
    expect(eew.hypocenter?.detailedName, '豊後水道');
    expect(eew.hypocenter?.depth, 40);
    expect(eew.hypocenter?.magnitude, 5.9);
    expect(eew.accuracy?.numberOfMagnitudeCalculation, 5);
    final forecast = eew.forecastIntensity!;
    expect(forecast.maxIntensity, JmaIntensity.fiveLower);
    expect(forecast.maxLpgmIntensity, JmaLpgmIntensity.one);
    expect(forecast.regions, hasLength(12));
    expect(forecast.regions.first.isArrived, isTrue);
    expect(
      forecast.regions[1].arrivalTime,
      DateTime.utc(2024, 4, 17, 14, 15, 2),
    );
    expect(eew.warning?.zones.map((zone) => zone.name), ['四国', '九州', '中国']);
    expect(eew.warning?.prefectures, hasLength(5));
    expect(eew.warning?.regions, hasLength(9));
  });

  test('取消報は取り消した報と同じ情報番号で、別の報として扱うこと', () {
    final reports = resolver.resolve([
      _xmlFrame('77_01_33_240613_VXSE45.xml', title: forecastTitle),
    ]);

    final cancel = reports[0]!;
    expect(cancel.serialNo, 32);
    expect(cancel.isCanceled, isTrue);
    expect(cancel.isLastInfo, isTrue);
    expect(cancel.isWarning, isNull);
    expect(cancel.forecastIntensity, isNull);
    expect(cancel.key, (
      eventId: '20240417231454',
      serialNo: 32,
      isCanceled: true,
    ));
  });

  test('同じ地震に警報電文と地震動予報があるときは地震動予報だけを使うこと', () {
    final reports = resolver.resolve([
      _xmlFrame('37_01_01_240613_VXSE43.xml', title: warningTitle),
      _xmlFrame('77_01_05_240613_VXSE45.xml', title: forecastTitle),
      _xmlFrame('37_01_03_240613_VXSE43.xml', title: warningTitle),
    ]);

    expect(reports.keys, [1]);
  });

  test('警報電文しかない地震は警報電文を使うこと', () {
    final reports = resolver.resolve([
      _xmlFrame('37_01_01_240613_VXSE43.xml', title: warningTitle),
      _xmlFrame('37_01_03_240613_VXSE43.xml', title: warningTitle),
    ]);

    expect(reports.keys, [0, 1]);
    expect(reports[1]?.isCanceled, isTrue);
  });

  test('EQMonitor 形式の EEW があればそちらを優先すること', () {
    final item = api.EewItemWithRelations(
      eventId: '20240417231454',
      type: .vxse45,
      status: .normal,
      infoType: .publication,
      serialNo: 5,
      headline: null,
      isCanceled: false,
      isWarning: true,
      isLastInfo: false,
      originTime: null,
      arrivalTime: null,
      accuracy: null,
      isPlum: false,
      editorialOffice: null,
      reportTime: DateTime.utc(2024, 4, 17, 14, 14, 59),
    );
    final reports = resolver.resolve([
      _xmlFrame('77_01_05_240613_VXSE45.xml', title: forecastTitle),
      EqMonitorEewReplayData(
        type: .eqMonitorEew,
        time: DateTime.utc(2024, 4, 17, 14, 15),
        json: jsonEncode(item.toJson()),
      ),
    ]);

    expect(reports.keys, [1]);
  });

  test('緊急地震速報以外の電文と読めない電文は読み飛ばすこと', () {
    final reports = resolver.resolve([
      JmaXmlTelegramReplayData(
        type: .jmaXmlTelegram,
        time: DateTime.utc(2024),
        title: '震源・震度に関する情報',
        telegram: '<Report/>',
      ),
      JmaXmlTelegramReplayData(
        type: .jmaXmlTelegram,
        time: DateTime.utc(2024),
        title: forecastTitle,
        telegram: '<Report>',
      ),
    ]);

    expect(reports, isEmpty);
  });
}
