import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:material_ui/material_ui.dart';

extension DesignSystemBuildContextX on BuildContext {
  DesignSystemThemeExtension get designSystem =>
      Theme.of(this).extension<DesignSystemThemeExtension>()!;
}
