import 'dart:io';

import 'package:jma_eew_xml/jma_eew_xml.dart';
import 'package:test/test.dart';

void main() {
  const parser = JmaEewXmlParser();
  JmaEewTelegram fixture(String name) =>
      parser.parse(File('test/fixtures/$name').readAsStringSync());

  group('気象庁サンプル電文', () {
    test('VXSE45 の警報を含む報を読めること', () {
      final telegram = fixture('77_01_05_240613_VXSE45.xml');

      expect(telegram.kind, JmaEewTelegramKind.seismicMotionForecast);
      expect(telegram.status, JmaTelegramStatus.normal);
      expect(telegram.infoType, JmaInfoType.publication);
      expect(telegram.editorialOffice, '気象庁本庁');
      expect(telegram.dateTime, DateTime.utc(2024, 4, 17, 14, 14, 59));
      expect(telegram.reportDateTime, DateTime.utc(2024, 4, 17, 14, 14, 59));
      expect(telegram.eventId, '20240417231454');
      expect(telegram.serial, 5);
      expect(telegram.headlineText, '豊後水道で地震　四国　九州　中国で強い揺れ');
      expect(telegram.isLastInfo, isFalse);
      expect(telegram.isCanceled, isFalse);
      expect(telegram.hasWarning, isTrue);

      final earthquake = telegram.earthquake!;
      expect(earthquake.originTime, DateTime.utc(2024, 4, 17, 14, 14, 47));
      expect(earthquake.arrivalTime, DateTime.utc(2024, 4, 17, 14, 14, 54));
      expect(earthquake.isAssumedHypocenter, isFalse);
      final hypocenter = earthquake.hypocenter;
      expect(hypocenter.code, '681');
      expect(hypocenter.name, '豊後水道');
      expect(hypocenter.coordinate!.latitude, 33.2);
      expect(hypocenter.coordinate!.longitude, 132.4);
      expect(hypocenter.coordinate!.height, -40000);
      expect(hypocenter.coordinate!.depthKilometers, 40);
      expect(hypocenter.coordinateDescription, '北緯３３．２度　東経１３２．４度　深さ　４０ｋｍ');
      expect(hypocenter.reduceCode, '9798');
      expect(hypocenter.reduceName, '豊後水道');
      expect(hypocenter.landOrSea, '海域');
      final accuracy = hypocenter.accuracy!;
      expect(accuracy.epicenterRank, 4);
      expect(accuracy.epicenterRank2, 4);
      expect(accuracy.depthRank, 4);
      expect(accuracy.magnitudeCalculationRank, 4);
      expect(accuracy.numberOfMagnitudeCalculation, 5);
      expect(earthquake.magnitude.value, 5.9);
      expect(earthquake.magnitude.type, 'Mj');
      expect(earthquake.magnitude.description, 'Ｍ５．９');

      final forecast = telegram.intensityForecast!;
      expect(forecast.maxIntensity.from, JmaEewIntensity.fiveLower);
      expect(forecast.maxIntensity.to, JmaEewIntensity.fiveLower);
      expect(forecast.maxLgIntensity!.from, JmaEewLgIntensity.one);
      expect(forecast.appendix!.maxIntChange, 0);
      expect(forecast.appendix!.maxLgIntChange, 0);
      expect(forecast.appendix!.maxIntChangeReason, 0);
      expect(forecast.areas, hasLength(12));

      final arrived = forecast.areas.first;
      expect(arrived.prefecture.code, '9380');
      expect(arrived.prefecture.name, '愛媛');
      expect(arrived.code, '622');
      expect(arrived.name, '愛媛県南予');
      expect(arrived.kind.code, '11');
      expect(arrived.isWarning, isTrue);
      expect(arrived.isPlum, isFalse);
      expect(arrived.isArrived, isTrue);
      expect(arrived.arrivalTime, isNull);

      final notArrived = forecast.areas[1];
      expect(notArrived.isArrived, isFalse);
      expect(notArrived.arrivalTime, DateTime.utc(2024, 4, 17, 14, 15, 2));

      final range = forecast.areas[10];
      expect(range.name, '山口県中部');
      expect(range.isWarning, isFalse);
      expect(range.intensity.from, JmaEewIntensity.three);
      expect(range.intensity.to, JmaEewIntensity.four);

      expect(telegram.warningComment!.text, '強い揺れに警戒してください。');
      expect(telegram.warningComment!.codes, ['0201']);

      expect(telegram.warningItems, hasLength(3));
      final regionItem = telegram.warningItems.first;
      expect(regionItem.level, JmaEewWarningAreaLevel.region);
      expect(regionItem.hadWarning, isTrue);
      expect(regionItem.areas.map((area) => area.name), ['四国', '九州', '中国']);
      expect(
        telegram.warningItems.map((item) => item.level),
        JmaEewWarningAreaLevel.values,
      );
    });

    test('警報の対象が増えた報で、Item ごとに直前の警報の有無を読めること', () {
      final telegram = fixture('77_01_17_240613_VXSE45.xml');

      final prefectureItems = telegram.warningItems
          .where((item) => item.level == JmaEewWarningAreaLevel.prefecture)
          .toList();
      expect(prefectureItems, hasLength(2));
      expect(prefectureItems[0].hadWarning, isTrue);
      expect(prefectureItems[1].hadWarning, isFalse);
      expect(prefectureItems[1].lastKind.name, 'なし');
      expect(prefectureItems[1].areas.first.name, '宮崎');

      final plum = telegram.intensityForecast!.areas.where((a) => a.isPlum);
      expect(plum, hasLength(3));
      expect(plum.first.kind.code, '19');
      expect(plum.first.isWarning, isTrue);
      expect(plum.first.arrivalTime, DateTime.utc(2024, 4, 17, 14, 15, 4));
    });

    test('第1報の空の見出し文を null として読むこと', () {
      final telegram = fixture('77_01_01_240613_VXSE45.xml');

      expect(telegram.serial, 1);
      expect(telegram.headlineText, isNull);
      expect(telegram.warningItems, isEmpty);
      expect(telegram.hasWarning, isFalse);
      expect(telegram.intensityForecast!.areas, isEmpty);
      expect(
        telegram.intensityForecast!.maxIntensity.from,
        JmaEewIntensity.three,
      );
    });

    test('取消報を読めること', () {
      final telegram = fixture('77_01_33_240613_VXSE45.xml');

      expect(telegram.infoType, JmaInfoType.cancellation);
      expect(telegram.isCanceled, isTrue);
      expect(telegram.serial, 32);
      expect(telegram.earthquake, isNull);
      expect(telegram.intensityForecast, isNull);
      expect(telegram.hasWarning, isFalse);
      expect(telegram.text, '先ほどの、緊急地震速報（地震動予報）を取り消します。');
    });

    test('VXSE44 の予報電文を読めること', () {
      final telegram = fixture('36_01_01_240613_VXSE44.xml');

      expect(telegram.kind, JmaEewTelegramKind.forecast);
      expect(telegram.kind.headType, 'VXSE44');
      expect(telegram.intensityForecast!.maxLgIntensity, isNull);
      expect(telegram.intensityForecast!.appendix, isNull);
      expect(
        telegram.earthquake!.hypocenter.accuracy!.magnitudeCalculationRank,
        2,
      );
    });

    test('VXSE43 の警報電文と取消報を読めること', () {
      final telegram = fixture('37_01_01_240613_VXSE43.xml');
      expect(telegram.kind, JmaEewTelegramKind.warning);
      expect(telegram.hasWarning, isTrue);
      expect(telegram.warningItems.every((item) => !item.hadWarning), isTrue);

      final cancel = fixture('37_01_03_240613_VXSE43.xml');
      expect(cancel.isCanceled, isTrue);
      expect(cancel.hasWarning, isFalse);
      expect(cancel.headlineText, '緊急地震速報（警報）を取り消します。');
    });
  });

  group('合成した電文', () {
    String report({
      String title = '緊急地震速報（地震動予報）',
      String infoType = '発表',
      String earthquake = '',
      String body = '',
    }) =>
        '﻿<?xml version="1.0" encoding="UTF-8"?>\n'
        '<!-- comment -->\n'
        '<Report xmlns="http://xml.kishou.go.jp/jmaxml1/">'
        '<Control><Title>$title</Title><DateTime>2026-01-01T00:00:00Z</DateTime>'
        '<Status>訓練</Status><EditorialOffice>大阪管区気象台</EditorialOffice>'
        '<PublishingOffice>気象庁</PublishingOffice></Control>'
        '<Head xmlns="http://xml.kishou.go.jp/jmaxml1/informationBasis1/">'
        '<Title>$title</Title><ReportDateTime>2026-01-01T09:00:00+09:00</ReportDateTime>'
        '<TargetDateTime>2026-01-01T09:00:00+09:00</TargetDateTime>'
        '<EventID>20260101085955</EventID><InfoType>$infoType</InfoType><Serial>3</Serial>'
        '<InfoKind>緊急地震速報</InfoKind><InfoKindVersion>1.2_0</InfoKindVersion>'
        '<Headline><Text/></Headline></Head>'
        '<Body xmlns="http://xml.kishou.go.jp/jmaxml1/body/seismology1/" '
        "xmlns:eb='http://xml.kishou.go.jp/jmaxml1/elementBasis1/'>"
        '$body$earthquake</Body></Report>';

    const plumEarthquake =
        '<Earthquake><OriginTime>2026-01-01T08:59:50+09:00</OriginTime>'
        '<Condition>仮定震源要素</Condition>'
        '<ArrivalTime>2026-01-01T08:59:55+09:00</ArrivalTime>'
        '<Hypocenter><Area><Name>石川県能登地方</Name><Code type="震央地名">390</Code>'
        '<eb:Coordinate description="北緯３７．５度　東経１３７．２度　深さ　１０ｋｍ">'
        '+37.5+137.2-10000/</eb:Coordinate>'
        '<ReduceName>石川県</ReduceName><ReduceCode type="短縮用震央地名">9390</ReduceCode></Area>'
        '<Accuracy><Epicenter rank="1" rank2="1">NaN</Epicenter><Depth rank="1">NaN</Depth>'
        '<MagnitudeCalculation rank="8">NaN</MagnitudeCalculation>'
        '<NumberOfMagnitudeCalculation>1</NumberOfMagnitudeCalculation></Accuracy></Hypocenter>'
        '<eb:Magnitude type="Mj" description="Ｍ１．０">1.0</eb:Magnitude></Earthquake>';

    test('仮定震源要素・別の名前空間接頭辞・BOM・コメントを扱えること', () {
      final telegram = parser.parse(report(earthquake: plumEarthquake));

      expect(telegram.status, JmaTelegramStatus.training);
      expect(telegram.headlineText, isNull);
      expect(telegram.earthquake!.isAssumedHypocenter, isTrue);
      expect(telegram.earthquake!.magnitude.value, 1.0);
      expect(telegram.earthquake!.hypocenter.coordinate!.depthKilometers, 10);
      expect(telegram.earthquake!.hypocenter.landOrSea, isNull);
      expect(telegram.intensityForecast, isNull);
    });

    test('M 不明・深さ不明・震源要素不明を値の補完なしに読むこと', () {
      final unknownDepth = parser.parse(
        report(
          earthquake: plumEarthquake
              .replaceFirst('+37.5+137.2-10000/', '+37.5+137.2/')
              .replaceFirst(
                '<eb:Magnitude type="Mj" description="Ｍ１．０">1.0',
                '<eb:Magnitude type="Mj" condition="不明" description="Ｍ不明">NaN',
              ),
        ),
      );
      final coordinate = unknownDepth.earthquake!.hypocenter.coordinate!;
      expect(coordinate.height, isNull);
      expect(coordinate.depthKilometers, isNull);
      expect(unknownDepth.earthquake!.magnitude.value, isNull);
      expect(unknownDepth.earthquake!.magnitude.condition, '不明');

      final unknownHypocenter = parser.parse(
        report(
          earthquake: plumEarthquake.replaceFirst(
            RegExp('<eb:Coordinate .*?</eb:Coordinate>'),
            '<eb:Coordinate description="震源要素不明" />',
          ),
        ),
      );
      expect(unknownHypocenter.earthquake!.hypocenter.coordinate, isNull);
      expect(
        unknownHypocenter.earthquake!.hypocenter.coordinateDescription,
        '震源要素不明',
      );
    });

    test('ごく浅い・700km 以上の深さを読むこと', () {
      final shallow = parser.parse(
        report(earthquake: plumEarthquake.replaceFirst('-10000/', '+0/')),
      );
      expect(shallow.earthquake!.hypocenter.coordinate!.depthKilometers, 0);

      final deep = parser.parse(
        report(earthquake: plumEarthquake.replaceFirst('-10000/', '-700000/')),
      );
      expect(deep.earthquake!.hypocenter.coordinate!.depthKilometers, 700);
    });

    test('「程度以上」と不明の予測震度、最終報、子要素の順序の入れ替わりを扱えること', () {
      final telegram = parser.parse(
        report(
          body:
              '<NextAdvisory>この情報をもって、緊急地震速報：最終報とします。</NextAdvisory>'
              '<Intensity><Forecast>'
              '<ForecastInt><To>over</To><From>5-</From></ForecastInt>'
              '<ForecastLgInt><From>不明</From><To>不明</To></ForecastLgInt>'
              '<Pref><Code>9170</Code><Name>石川</Name><Area><Code>390</Code><Name>石川県能登</Name>'
              '<Category><Kind><Name>緊急地震速報（予報）</Name><Code>09</Code></Kind></Category>'
              '<ForecastInt><From>不明</From><To>不明</To></ForecastInt>'
              '<ArrivalTime>2026-01-01T09:00:01+09:00</ArrivalTime></Area></Pref>'
              '</Forecast></Intensity>',
          earthquake: plumEarthquake,
        ),
      );

      expect(telegram.isLastInfo, isTrue);
      final forecast = telegram.intensityForecast!;
      expect(forecast.maxIntensity.from, JmaEewIntensity.fiveLower);
      expect(forecast.maxIntensity.isOver, isTrue);
      expect(forecast.maxLgIntensity!.from, JmaEewLgIntensity.unknown);
      final area = forecast.areas.single;
      expect(area.prefecture.name, '石川');
      expect(area.isPlum, isTrue);
      expect(area.isWarning, isFalse);
      expect(area.intensity.from, JmaEewIntensity.unknown);
      expect(telegram.hasWarning, isFalse);
    });

    test('文字参照と CDATA を展開すること', () {
      final telegram = parser.parse(
        report(
          infoType: '取消',
          body: '<Text>A &amp; B &lt;&#x3042;&#12354;&gt; <![CDATA[<x>&amp;]]></Text>',
        ),
      );
      expect(telegram.text, 'A & B <ああ> <x>&amp;');
    });

    test('緊急地震速報以外の電文は JmaEewXmlUnsupportedTitleException になること', () {
      expect(
        () => parser.parse(report(title: '緊急地震速報配信テスト')),
        throwsA(isA<JmaEewXmlUnsupportedTitleException>()),
      );
    });

    test('壊れた XML は JmaEewXmlSyntaxException になること', () {
      expect(
        () => parser.parse('<Report><Control></Report>'),
        throwsA(isA<JmaEewXmlSyntaxException>()),
      );
      expect(
        () => parser.parse('<Report><Control>'),
        throwsA(isA<JmaEewXmlSyntaxException>()),
      );
      expect(
        () => parser.parse('<!DOCTYPE x [<!ENTITY a "b">]><Report/>'),
        throwsA(isA<JmaEewXmlSyntaxException>()),
      );
    });

    test('必須要素がない電文は JmaEewXmlStructureException になること', () {
      expect(
        () => parser.parse('<Report><Control/><Head/><Body/></Report>'),
        throwsA(isA<JmaEewXmlStructureException>()),
      );
      expect(
        () => parser.parse(report(earthquake: '<Earthquake/>')),
        throwsA(isA<JmaEewXmlStructureException>()),
      );
    });
  });
}
