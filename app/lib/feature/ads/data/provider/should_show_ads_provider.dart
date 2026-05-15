import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:eqmonitor/feature/ads/data/provider/ads_server_flag_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'should_show_ads_provider.g.dart';

/// 広告を表示すべきかどうかを返す。
/// 以下のいずれかに該当する場合は false:
/// - Proユーザー
/// - サーバフラグ (ads_enabled) が false
/// - EEW発報中
/// - ユーザーがオプトアウト済み
@Riverpod(keepAlive: true)
bool shouldShowAds(Ref ref) {
  if (ref.watch(isProProvider)) {
    return false;
  }
  if (!ref.watch(adsServerFlagProvider)) {
    return false;
  }
  final eewAlive = ref.watch(eewAliveTelegramProvider);
  if (eewAlive != null && eewAlive.isNotEmpty) {
    return false;
  }
  if (ref.watch(adsOptOutProvider)) {
    return false;
  }
  return true;
}
