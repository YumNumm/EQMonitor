import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

EewTelegramItem _makeEew({
  required String eventId,
  bool isPlum = false,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2025, 1, 1, 12),
  isPlum: isPlum,
);

class _FakeEewAliveTelegram extends EewAliveTelegram {
  new(this._value);
  final List<EewTelegramItem>? _value;

  @override
  List<EewTelegramItem>? build() => _value;
}

ProviderContainer _containerWithAlive(List<EewTelegramItem>? aliveState) {
  final container = ProviderContainer(
    overrides: [
      eewAliveTelegramProvider.overrideWith(
        () => _FakeEewAliveTelegram(aliveState),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('eewAliveNormalTelegram', () {
    test('eewAliveTelegram が null の場合は空リストを返すこと', () {
      final container = _containerWithAlive(null);
      final result = container.read(eewAliveNormalTelegramProvider);
      expect(result, isEmpty);
    });

    test('isPlum=true のEEWは除外されること', () {
      final container = _containerWithAlive([
        _makeEew(eventId: 'a'),
        _makeEew(eventId: 'b', isPlum: true),
        _makeEew(eventId: 'c'),
      ]);
      final result = container.read(eewAliveNormalTelegramProvider);
      expect(result.map((e) => e.eventId).toList(), ['a', 'c']);
    });

    test('全件 isPlum の場合は空リストになること', () {
      final container = _containerWithAlive([
        _makeEew(eventId: 'a', isPlum: true),
        _makeEew(eventId: 'b', isPlum: true),
      ]);
      final result = container.read(eewAliveNormalTelegramProvider);
      expect(result, isEmpty);
    });

    test('全件 isPlum=false の場合はそのまま返ること', () {
      final eews = [
        _makeEew(eventId: 'a'),
        _makeEew(eventId: 'b'),
        _makeEew(eventId: 'c'),
      ];
      final container = _containerWithAlive(eews);
      final result = container.read(eewAliveNormalTelegramProvider);
      expect(result.map((e) => e.eventId).toList(), ['a', 'b', 'c']);
    });

    test('入力空リストの場合は空リストを返すこと', () {
      final container = _containerWithAlive([]);
      final result = container.read(eewAliveNormalTelegramProvider);
      expect(result, isEmpty);
    });
  });
}
