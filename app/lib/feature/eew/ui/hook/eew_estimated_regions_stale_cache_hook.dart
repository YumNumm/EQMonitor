import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 推定震度を取得する Hook。
///
/// [use] は内部で [useRef] を呼び出すため、[HookWidget] の `build` 内から
/// 呼び出し順序が変わらない形で使うこと（`use()` の実体は
/// `HookElement._currentHookElement` を参照するため、トップレベル関数か
/// クラスの static メソッドかは Hook の登録順序に影響しない）。
class EewEstimatedRegionsStaleCacheHook {
  const EewEstimatedRegionsStaleCacheHook._();

  /// 推定震度を取得する。新しい EEW 報へ切り替わって再計算中も、
  /// 直前の結果を表示し続ける。
  static List<EewEstimatedRegion>? use({
    required WidgetRef ref,
    required EewTelegramItem? eew,
    required bool isEnabled,
  }) {
    final cache = useRef<List<EewEstimatedRegion>?>(null);

    final asyncValue = isEnabled && eew != null
        ? ref.watch(eewEstimatedRegionIntensityProvider(eew))
        : null;

    if (!isEnabled || eew == null) {
      cache.value = null;
      return null;
    }

    if (asyncValue != null && asyncValue.hasValue) {
      cache.value = asyncValue.requireValue;
    }

    return asyncValue?.when(
      data: (data) => data,
      loading: () => cache.value,
      error: (_, _) => cache.value,
    );
  }
}
