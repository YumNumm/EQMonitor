// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/double_theme_encoder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'shape_theme_extension.tailor.dart';

@doubleThemeEncoder
@tailorMixinComponent
class const ShapeThemeExtension({
  required final double xs,
  required final double sm,
  required final double md,
  required final double lg,
  required final double xl,
  required final double button,
  required final double card,
  required final double sheet,
  required final double pill,
}) extends ThemeExtension<ShapeThemeExtension>
    with _$ShapeThemeExtensionTailorMixin {
  factory standard() => const ShapeThemeExtension(
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 24,
    button: 20,
    card: 24,
    sheet: 28,
    pill: 999,
  );
}
