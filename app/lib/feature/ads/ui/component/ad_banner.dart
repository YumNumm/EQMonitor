import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/ads/data/ad_unit_id.dart';
import 'package:eqmonitor/feature/ads/data/provider/should_show_ads_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// バナー広告ウィジェット。
/// shouldShowAdsProvider が false の場合は何も表示しない。
/// Web・デスクトップでは表示しない。
class AdBanner extends HookConsumerWidget {
  const new({super.key});

  /// バナー広告を表示する余地があるかどうか。
  /// レイアウト側で広告領域を詰めるかどうかの判定に利用する。
  static bool isVisible(WidgetRef ref) {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return false;
    }
    return ref.watch(shouldShowAdsProvider);
  }

  /// バナー広告が占める高さ。非表示の場合は 0。
  /// 広告を表示しないときに空白が残らないよう、
  /// 高さを固定で確保している箇所ではこの値を使う。
  static double heightOf(WidgetRef ref) =>
      isVisible(ref) ? AdSize.banner.height.toDouble() : 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isVisible(ref)) {
      return const SizedBox.shrink();
    }

    return const _BannerAdWidget();
  }
}

class _BannerAdWidget extends HookConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adState = useState<BannerAd?>(null);
    final isLoaded = useState(false);

    const adSize = AdSize.banner;

    useEffect(() {
      final ad = BannerAd(
        size: adSize,
        adUnitId: AdUnitId.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) => isLoaded.value = true,
          onAdFailedToLoad: (ad, error) async {
            adState.value = null;
            await ad.dispose();
          },
        ),
        request: const AdRequest(),
      );
      unawaited(ad.load());
      adState.value = ad;
      return ad.dispose;
    }, []);

    final ad = adState.value;
    if (ad == null || !isLoaded.value) {
      return SizedBox(height: adSize.height.toDouble());
    }

    return SafeArea(
      child: SizedBox(
        height: adSize.height.toDouble(),
        child: AdWidget(ad: ad),
      ),
    );
  }
}
