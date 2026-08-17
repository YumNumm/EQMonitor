import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:eqmonitor/feature/ads/data/provider/ads_server_flag_provider.dart';
import 'package:eqmonitor/feature/ads/data/provider/should_show_ads_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `shouldShowAdsProvider` の依存を上書きするためのスタブ群。
class _StubEewAliveTelegram extends EewAliveTelegram {
  new(this._value);

  final List<EewTelegramItem>? _value;

  @override
  List<EewTelegramItem>? build() => _value;
}

class _StubAdsOptOut extends AdsOptOutNotifier {
  new({required bool initial}) : _initial = initial;

  final bool _initial;

  @override
  Future<bool> build() async => _initial;
}

ProviderContainer _container({
  required bool isPro,
  required bool adsServerFlag,
  required List<EewTelegramItem>? eewAlive,
  required bool adsOptOut,
}) {
  return ProviderContainer(
    overrides: [
      isProProvider.overrideWith((ref) => isPro),
      adsServerFlagProvider.overrideWith((ref) => adsServerFlag),
      eewAliveTelegramProvider.overrideWith(
        () => _StubEewAliveTelegram(eewAlive),
      ),
      adsOptOutProvider.overrideWith(() => _StubAdsOptOut(initial: adsOptOut)),
    ],
  );
}

void main() {
  group('shouldShowAdsProvider', () {
    test('全条件 OK のとき true (広告表示)', () {
      final container = _container(
        isPro: false,
        adsServerFlag: true,
        eewAlive: const [],
        adsOptOut: false,
      );
      addTearDown(container.dispose);

      expect(container.read(shouldShowAdsProvider), isTrue);
    });

    test('Pro ユーザーは false', () {
      final container = _container(
        isPro: true,
        adsServerFlag: true,
        eewAlive: const [],
        adsOptOut: false,
      );
      addTearDown(container.dispose);

      expect(container.read(shouldShowAdsProvider), isFalse);
    });

    test('サーバフラグが false のとき false', () {
      final container = _container(
        isPro: false,
        adsServerFlag: false,
        eewAlive: const [],
        adsOptOut: false,
      );
      addTearDown(container.dispose);

      expect(container.read(shouldShowAdsProvider), isFalse);
    });

    test('オプトアウト済みのとき false', () async {
      final container = _container(
        isPro: false,
        adsServerFlag: true,
        eewAlive: const [],
        adsOptOut: true,
      );
      addTearDown(container.dispose);

      await container.read(adsOptOutProvider.future);
      expect(container.read(shouldShowAdsProvider), isFalse);
    });

    test('EEW Alive が null のときは表示可 (true)', () {
      final container = _container(
        isPro: false,
        adsServerFlag: true,
        eewAlive: null,
        adsOptOut: false,
      );
      addTearDown(container.dispose);

      expect(container.read(shouldShowAdsProvider), isTrue);
    });

    test('Pro が最優先 (他条件すべて NG でも Pro なら false)', () {
      final container = _container(
        isPro: true,
        adsServerFlag: false,
        eewAlive: null,
        adsOptOut: true,
      );
      addTearDown(container.dispose);

      expect(container.read(shouldShowAdsProvider), isFalse);
    });
  });
}
