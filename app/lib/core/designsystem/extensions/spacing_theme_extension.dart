// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/double_theme_encoder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'spacing_theme_extension.tailor.dart';

@doubleThemeEncoder
@tailorMixinComponent
class SpacingThemeExtension extends ThemeExtension<SpacingThemeExtension>
    with _$SpacingThemeExtensionTailorMixin {
  const new({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
  });

  factory standard() => const SpacingThemeExtension(
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 24,
    xxxl: 28,
    xxxxl: 32,
  );

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double xxxxl;
}
