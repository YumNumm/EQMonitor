import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// EEW震度予報区域レイヤー
///
/// 現在のMapLibreパッケージではベクタータイルのフィルター操作が
/// サポートされていないため、この機能は後日実装予定です。
class EewForecastRegionLayer extends HookConsumerWidget {
  const EewForecastRegionLayer({
    required this.eew,
    required this.displayMode,
    super.key,
  });

  final EewItemWithRelations? eew;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(impl): ベクタータイルのフィルター操作が実装されたら
    // 震度予報区域の塗りつぶしを実装する
    return const SizedBox.shrink();
  }
}
