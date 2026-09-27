// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/double_theme_encoder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'spacing_theme_extension.tailor.dart';

@doubleThemeEncoder
@tailorMixinComponent
class const SpacingThemeExtension({
  required final double xs,
  required final double sm,
  required final double md,
  required final double lg,
  required final double xl,
  required final double xxl,
  required final double xxxl,
  required final double xxxxl,
}) extends ThemeExtension<SpacingThemeExtension>
    with _$SpacingThemeExtensionTailorMixin {
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
}
