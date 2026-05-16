import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

/// assets/debug/eew/noto_peninsula_20240101/ 以下の変換済み JSON ファイルが
/// EewItemWithRelations としてパースでき、EewTelegramItem に変換できることを確認する。
void main() {
  const scenarioDir = 'assets/debug/eew/noto_peninsula_20240101';

  late List<String> fileNames;

  setUpAll(() {
    final indexFile = File('$scenarioDir/index.json');
    expect(
      indexFile.existsSync(),
      isTrue,
      reason: 'index.json が存在しない。scripts/convert_debug_eew.py を実行してください。',
    );
    final index =
        jsonDecode(indexFile.readAsStringSync()) as Map<String, dynamic>;
    fileNames = (index['files'] as List<dynamic>).cast<String>();
    expect(fileNames, isNotEmpty);
  });

  test('index.json が有効なフォーマットである', () {
    final indexFile = File('$scenarioDir/index.json');
    final index =
        jsonDecode(indexFile.readAsStringSync()) as Map<String, dynamic>;
    expect(index['name'], isA<String>());
    expect(index['eventId'], equals('20240101161010'));
    expect(index['files'], isA<List<dynamic>>());
    expect((index['files'] as List<dynamic>).length, greaterThan(0));
  });

  test('すべての EEW JSON ファイルが EewItemWithRelations としてパースできる', () {
    for (final name in fileNames) {
      final file = File('$scenarioDir/$name');
      expect(
        file.existsSync(),
        isTrue,
        reason: '$name が存在しない',
      );
      final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      // EewItemWithRelations.fromJson でパースできること
      final item = EewItemWithRelations.fromJson(raw);
      expect(item.eventId, equals('20240101161010'));
      expect(item.type, equals(TelegramType.vxse45));
      expect(item.status, equals(TelegramStatus.normal));
      expect(item.serialNo, greaterThan(0));
    }
  });

  test('EewItemWithRelations → EewTelegramItem の変換が成功する', () {
    for (final name in fileNames) {
      final file = File('$scenarioDir/$name');
      final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final item = EewItemWithRelations.fromJson(raw);

      // EewTelegramItem に変換できること
      final telegram = item.toEewTelegramItem;
      expect(telegram.eventId, equals(item.eventId));
      expect(telegram.serialNo, equals(item.serialNo.toInt()));
      expect(telegram.isCanceled, equals(item.isCanceled));
    }
  });

  test('reportTime が昇順に並んでいる (index.json の files 順)', () {
    final items = fileNames.map((name) {
      final raw =
          jsonDecode(
                File('$scenarioDir/$name').readAsStringSync(),
              )
              as Map<String, dynamic>;
      return EewItemWithRelations.fromJson(raw);
    }).toList();

    for (var i = 1; i < items.length; i++) {
      expect(
        items[i].reportTime.isAfter(items[i - 1].reportTime) ||
            items[i].reportTime.isAtSameMomentAs(items[i - 1].reportTime),
        isTrue,
        reason:
            '${fileNames[i]} の reportTime が前の電文より古い: '
            '${items[i].reportTime} < ${items[i - 1].reportTime}',
      );
    }
  });

  test('最終電文の isLastInfo が true である', () {
    final lastItem = EewItemWithRelations.fromJson(
      jsonDecode(
            File('$scenarioDir/${fileNames.last}').readAsStringSync(),
          )
          as Map<String, dynamic>,
    );
    expect(lastItem.isLastInfo, isTrue);
  });

  test('時刻オフセット適用後も正常に EewTelegramItem に変換できる', () {
    final raw =
        jsonDecode(
              File('$scenarioDir/${fileNames.first}').readAsStringSync(),
            )
            as Map<String, dynamic>;
    final item = EewItemWithRelations.fromJson(raw);

    const offset = Duration(hours: 5, minutes: 30);
    final shifted = item.copyWith(
      reportTime: item.reportTime.add(offset),
      originTime: item.originTime?.add(offset),
      arrivalTime: item.arrivalTime?.add(offset),
    );

    expect(
      shifted.reportTime.difference(item.reportTime),
      equals(offset),
    );
    if (item.originTime != null) {
      expect(
        shifted.originTime!.difference(item.originTime!),
        equals(offset),
      );
    }

    // EewTelegramItem への変換も通ること
    expect(shifted.toEewTelegramItem, returnsNormally);
  });
}
