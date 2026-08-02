import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/notifier/eew_map_focus.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('clearFocus後にrefocusでisFocusedがtrueに戻る', () {
    final aliveEews = [
      _sampleEew(eventId: 'event', latitude: 35.5, longitude: 139.5),
    ];
    final container = ProviderContainer(
      overrides: [
        eewAliveTelegramProvider.overrideWithValue(aliveEews),
        shakeDetectionProvider.overrideWithValue(const []),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(eewMapFocusProvider.notifier);
    final initialDecision = notifier.sync();

    expect(initialDecision.state.isFocused, isTrue);
    expect(container.read(eewMapFocusProvider).isFocused, isTrue);

    notifier.clearFocus();

    expect(container.read(eewMapFocusProvider).isFocused, isFalse);
    expect(container.read(eewMapFocusProvider).focusedEventId, 'event');

    final refocusDecision = notifier.refocus();

    expect(refocusDecision.state.isFocused, isTrue);
    expect(refocusDecision.shouldFit, isTrue);
    expect(container.read(eewMapFocusProvider).isFocused, isTrue);
  });

  test('markAppliedを呼ぶまでhasAppliedFocusはfalseのまま', () {
    final container = ProviderContainer(
      overrides: [
        eewAliveTelegramProvider.overrideWithValue([_sampleEew()]),
        shakeDetectionProvider.overrideWithValue(const []),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(eewMapFocusProvider.notifier);
    final decision = notifier.sync();

    expect(container.read(eewMapFocusProvider).hasAppliedFocus, isFalse);

    notifier.markApplied(decision: decision);

    expect(container.read(eewMapFocusProvider).hasAppliedFocus, isTrue);
    expect(notifier.sync().shouldFit, isFalse);
  });
}

final _now = DateTime.utc(2025, 1, 1, 12);

EewTelegramItem _sampleEew({
  String eventId = 'event',
  DateTime? reportTime,
  double? latitude = 35.5,
  double? longitude = 139.5,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: reportTime ?? _now,
  isPlum: false,
  hypocenter: latitude == null || longitude == null
      ? null
      : EewHypocenterInfo(
          code: '101',
          name: '東京都',
          latitude: latitude,
          longitude: longitude,
        ),
);
