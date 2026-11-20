import 'package:eqmonitor/feature/release_highlight/data/logic/release_version_parser.dart';
import 'package:eqmonitor/feature/release_highlight/data/model/release_highlight.dart';
import 'package:version/version.dart';

class const ReleaseHighlightSelector({
  final ReleaseVersionParser parser = const ReleaseVersionParser(),
}) {
  /// 既読のバージョンより新しく、現在のバージョン以下の案内を新しい順に返す。
  List<ReleaseHighlight> select({
    required String currentVersion,
    required String? seenVersion,
  }) {
    final current = parser.tryParse(currentVersion);
    if (current == null) {
      return const [];
    }
    final seen = seenVersion == null ? null : parser.tryParse(seenVersion);
    final candidates = <(Version, ReleaseHighlight)>[
      for (final highlight in ReleaseHighlight.values)
        if (parser.tryParse(highlight.version) case final version?
            when version <= current && (seen == null || version > seen))
          (version, highlight),
    ]..sort((a, b) => b.$1.compareTo(a.$1));
    return [for (final (_, highlight) in candidates) highlight];
  }
}
