import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

EewTelegramItem _eew({
  required String eventId,
  required int serialNo,
  bool isCanceled = false,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: serialNo,
  isCanceled: isCanceled,
  isLastInfo: false,
  reportTime: DateTime.utc(2025, 1, 1, 12),
  isPlum: false,
);

class _StubEew extends Eew {
  _StubEew([this._initial = const <EewTelegramItem>[]]);
  final List<EewTelegramItem> _initial;

  @override
  AsyncValue<List<EewTelegramItem>> build() => AsyncData(_initial);
}

ProviderContainer _container({List<EewTelegramItem>? initial}) {
  final container = ProviderContainer(
    overrides: [
      eewProvider.overrideWith(
        () => _StubEew(initial ?? const <EewTelegramItem>[]),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('Eew.upsert', () {
    test('未知の eventId の場合は新規追加されること', () {
      final container = _container();
      final notifier = container.read(eewProvider.notifier);
      notifier.upsert(_eew(eventId: 'e1', serialNo: 1));

      final state = container.read(eewProvider).value!;
      expect(state, hasLength(1));
      expect(state.single.eventId, 'e1');
    });

    test('同一 eventId で serialNo が大きい場合は置き換えられること', () {
      final container = _container(
        initial: [_eew(eventId: 'e1', serialNo: 1)],
      );
      final notifier = container.read(eewProvider.notifier);
      notifier.upsert(_eew(eventId: 'e1', serialNo: 2, isCanceled: true));

      final state = container.read(eewProvider).value!;
      expect(state, hasLength(1));
      expect(state.single.serialNo, 2);
      expect(state.single.isCanceled, isTrue);
    });

    test('同一 eventId で serialNo が等しい場合も置き換えられること (<= で判定)', () {
      final container = _container(
        initial: [_eew(eventId: 'e1', serialNo: 2)],
      );
      final notifier = container.read(eewProvider.notifier);
      // 同じ serialNo だが isCanceled が異なるオブジェクト
      notifier.upsert(_eew(eventId: 'e1', serialNo: 2, isCanceled: true));

      final state = container.read(eewProvider).value!;
      expect(state.single.isCanceled, isTrue);
    });

    test('同一 eventId で serialNo が小さい場合は無視されること', () {
      final container = _container(
        initial: [_eew(eventId: 'e1', serialNo: 5)],
      );
      final notifier = container.read(eewProvider.notifier);
      notifier.upsert(_eew(eventId: 'e1', serialNo: 4, isCanceled: true));

      final state = container.read(eewProvider).value!;
      expect(state.single.serialNo, 5);
      expect(state.single.isCanceled, isFalse);
    });

    test('複数の eventId が並列に存在できること', () {
      final container = _container(
        initial: [_eew(eventId: 'e1', serialNo: 1)],
      );
      final notifier = container.read(eewProvider.notifier);
      notifier.upsert(_eew(eventId: 'e2', serialNo: 1));
      notifier.upsert(_eew(eventId: 'e3', serialNo: 1));

      final state = container.read(eewProvider).value!;
      expect(state.map((e) => e.eventId).toSet(), {'e1', 'e2', 'e3'});
    });

    test('初期 state が空でも upsert で追加できること', () {
      final container = _container();
      final notifier = container.read(eewProvider.notifier);
      notifier.upsert(_eew(eventId: 'first', serialNo: 1));
      notifier.upsert(_eew(eventId: 'second', serialNo: 1));

      final state = container.read(eewProvider).value!;
      expect(state.map((e) => e.eventId).toList(), ['first', 'second']);
    });
  });
}
