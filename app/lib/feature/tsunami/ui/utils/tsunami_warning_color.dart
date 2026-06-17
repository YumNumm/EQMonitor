// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';

import 'package:eqmonitor_api/eqmonitor_api.dart';

abstract final class TsunamiWarningColor {
  static List<Color> stripeColors(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const [
          Color(0xFF800080),
          Color(0xFF000000),
        ],
        TsunamiWarningKind.warning => const [
          Color(0xFFFF0000),
          Color(0xFF000000),
        ],
        TsunamiWarningKind.advisory => const [
          Color(0xFFFFCC00),
          Color(0xFF996600),
        ],
        TsunamiWarningKind.forecast ||
        TsunamiWarningKind.none => const [],
      };

  static Color headerColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const Color(0xFF6A006A),
        TsunamiWarningKind.warning => const Color(0xFFB31A1A),
        TsunamiWarningKind.advisory => const Color(0xFFCC9900),
        TsunamiWarningKind.forecast => const Color(0xFF1E5AA0),
        TsunamiWarningKind.none => const Color(0xFF757575),
      };

  static Color mapFillColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning =>
          const Color(0xFF800080).withValues(alpha: 0.4),
        TsunamiWarningKind.warning =>
          const Color(0xFFFF0000).withValues(alpha: 0.4),
        TsunamiWarningKind.advisory =>
          const Color(0xFFFFCC00).withValues(alpha: 0.4),
        TsunamiWarningKind.forecast =>
          const Color(0xFF1E5AA0).withValues(alpha: 0.3),
        TsunamiWarningKind.none => const Color(0x00000000),
      };

  static Color mapBorderColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const Color(0xFF800080),
        TsunamiWarningKind.warning => const Color(0xFFFF0000),
        TsunamiWarningKind.advisory => const Color(0xFFFFCC00),
        TsunamiWarningKind.forecast => const Color(0xFF1E5AA0),
        TsunamiWarningKind.none => const Color(0x00000000),
      };

  static String displayName(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => '大津波警報',
        TsunamiWarningKind.warning => '津波警報',
        TsunamiWarningKind.advisory => '津波注意報',
        TsunamiWarningKind.forecast => '津波予報',
        TsunamiWarningKind.none => '解除',
      };

  /// Returns the highest [TsunamiWarningKind] across all regions,
  /// falling back to [TsunamiWarningKind.none] for an empty list.
  static TsunamiWarningKind resolveMaxKind(
    List<MergedForecastRegion> regions,
  ) {
    if (regions.isEmpty) {
      return TsunamiWarningKind.none;
    }
    const order = [
      TsunamiWarningKind.majorWarning,
      TsunamiWarningKind.warning,
      TsunamiWarningKind.advisory,
      TsunamiWarningKind.forecast,
      TsunamiWarningKind.none,
    ];
    var max = TsunamiWarningKind.none;
    for (final region in regions) {
      final idx = order.indexOf(region.kind);
      if (idx < order.indexOf(max)) {
        max = region.kind;
      }
    }
    return max;
  }
}
