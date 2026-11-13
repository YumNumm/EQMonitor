import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

enum RegionSelectionMode { single, multiple }

final class const RegionSelectionRequest({
  final String title = '地域を選択',
  final List<RegionKind> kinds = const [.prefecture, .region, .city],
  final RegionSelectionMode mode = .single,
  final List<RegionOption> initialSelection = const [],
  final String initialQuery = '',
  final bool notification = false,
  final bool allowEmpty = false,

  /// 一覧・地図に表示するが選択できない地域。登録済みの地域などを渡す。
  final List<RegionOption> unavailable = const [],

  /// [unavailable] の地域に添える理由の表示。
  final String unavailableLabel = '選択不可',
});
