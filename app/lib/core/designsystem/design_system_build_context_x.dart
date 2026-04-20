import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:flutter/material.dart';

extension DesignSystemBuildContextX on BuildContext {
  DesignSystemThemeExtension get designSystem =>
      Theme.of(this).designSystemThemeExtension;
}
