import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart';
import 'package:test/test.dart';

void main() {
  group('liveMonitorMapObscuredInsets', () {
    test('system insetとCard高さが0なら追加遮蔽量も0になる', () {
      final insets = liveMonitorMapObscuredInsets(
        systemTopInset: 0,
        systemBottomInset: 0,
        topCardHeight: 0,
        bottomCardHeight: 0,
      );

      expect(insets, (top: 0, bottom: 0));
    });

    test('system insetがsafe spacing未満ならCard高さだけを返す', () {
      final insets = liveMonitorMapObscuredInsets(
        systemTopInset: 4,
        systemBottomInset: 7,
        topCardHeight: 20,
        bottomCardHeight: 30,
      );

      expect(insets, (top: 20, bottom: 30));
    });

    test('system insetがsafe spacingを超えた分を上下のCard高さへ加える', () {
      final insets = liveMonitorMapObscuredInsets(
        systemTopInset: 24,
        systemBottomInset: 34,
        topCardHeight: 10,
        bottomCardHeight: 20,
      );

      expect(insets, (top: 26, bottom: 46));
    });

    test('負のCard高さは0として扱いsystem insetの追加分だけを返す', () {
      final insets = liveMonitorMapObscuredInsets(
        systemTopInset: 18,
        systemBottomInset: 28,
        topCardHeight: -10,
        bottomCardHeight: -20,
      );

      expect(insets, (top: 10, bottom: 20));
    });
  });
}
