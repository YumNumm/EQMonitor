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
});
