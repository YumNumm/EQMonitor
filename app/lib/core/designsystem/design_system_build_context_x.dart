import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:material_ui/material_ui.dart';

extension DesignSystemBuildContextX on BuildContext {
  DesignSystemThemeExtension get designSystem =>
      Theme.of(this).extension<DesignSystemThemeExtension>().orFailBecause(
        'AppThemeDataBuilder.build が必ず DesignSystemThemeExtension を登録するため',
      );
}
