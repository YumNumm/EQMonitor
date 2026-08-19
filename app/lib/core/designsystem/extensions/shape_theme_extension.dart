// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/double_theme_encoder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'shape_theme_extension.tailor.dart';

@doubleThemeEncoder
@tailorMixinComponent
class ShapeThemeExtension extends ThemeExtension<ShapeThemeExtension>
    with _$ShapeThemeExtensionTailorMixin {
  const new({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.button,
    required this.card,
    required this.sheet,
    required this.pill,
  });

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

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double button;
  final double card;
  final double sheet;
  final double pill;
}
