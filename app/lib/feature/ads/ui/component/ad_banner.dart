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

class AdBannerPersistentDelegate extends SliverPersistentHeaderDelegate {
  const new();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const AdBanner();
  }

  @override
  double get maxExtent => AdSize.banner.height.toDouble();

  @override
  double get minExtent => AdSize.banner.height.toDouble();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
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
