import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/ads/data/ad_unit_id.dart';
import 'package:eqmonitor/feature/ads/data/provider/should_show_ads_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// バナー広告ウィジェット。
/// shouldShowAdsProvider が false の場合は何も表示しない。
/// Web・デスクトップでは表示しない。
class AdBanner extends HookConsumerWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return const SizedBox.shrink();
    }

    final shouldShow = ref.watch(shouldShowAdsProvider);
    if (!shouldShow) {
      return const SizedBox.shrink();
    }

    return const _BannerAdWidget();
  }
}

class _BannerAdWidget extends HookConsumerWidget {
  const _BannerAdWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adState = useState<BannerAd?>(null);
    final isLoaded = useState(false);

    useEffect(
      () {
        final ad = BannerAd(
          size: AdSize.banner,
          adUnitId: adUnitIdBanner,
          listener: BannerAdListener(
            onAdLoaded: (_) => isLoaded.value = true,
            onAdFailedToLoad: (ad, error) {
              unawaited(ad.dispose());
              adState.value = null;
            },
          ),
          request: const AdRequest(),
        );
        unawaited(ad.load());
        adState.value = ad;
        return ad.dispose;
      },
      [],
    );

    final ad = adState.value;
    if (ad == null || !isLoaded.value) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
