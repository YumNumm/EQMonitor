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

  /// 検索語がない間、都道府県 → 細分化地域 → 市区町村 の階層で一覧を辿る。
  ///
  /// [kinds] が細分化地域または市区町村を含む場合に指定する。都道府県・
  /// 細分化地域も選べる場合は、進んだ先の先頭に「全体」の行が加わる。
  final bool hierarchical = false,

  /// 一覧・地図に表示するが選択できない地域。登録済みの地域などを渡す。
  final List<RegionOption> unavailable = const [],

  /// [unavailable] の地域に添える理由の表示。
  final String unavailableLabel = '選択不可',
});
