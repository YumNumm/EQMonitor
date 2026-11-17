import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class const AppListTile._({
  required final String title,
  required final String subtitle,
  // ignore: library_private_types_in_public_api
  required final _AppListTileType type,
  final bool? value,
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged,
  final void Function()? onTap,
  final Widget? trailing,
}) extends StatelessWidget {
  factory switchListTile({
    required String title,
    required String subtitle,
    required bool value,
    // ignore: avoid_positional_boolean_parameters
    required void Function(bool) onChanged,
    Widget? trailing,
  }) => AppListTile._(
    title: title,
    subtitle: subtitle,
    value: value,
    onChanged: onChanged,
    trailing: trailing,
    type: _AppListTileType.switchListTile,
  );

  factory listTile({
    required String title,
    required String subtitle,
    Widget? trailing,
    void Function()? onTap,
  }) => AppListTile._(
    title: title,
    subtitle: subtitle,
    trailing: trailing,
    onTap: onTap,
    type: _AppListTileType.listTile,
  );

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final backgroundColor = designSystem.colorTheme.secondaryContainer;
    final textColor = designSystem.colorTheme.onSecondaryContainer;

    final shape = RoundedSuperellipseBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return switch (type) {
      _AppListTileType.switchListTile => AppSwitchListTile(
        shape: shape,
        tileColor: backgroundColor,
        title: title,
        subtitle: subtitle,
        value: value ?? false,
        onChanged: onChanged,
        trailing: trailing,
      ),
      _AppListTileType.listTile => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: shape,
        tileColor: backgroundColor,
        textColor: textColor,
        title: Text(title, style: const TextStyle(fontWeight: .bold)),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    };
  }
}

enum _AppListTileType { switchListTile, listTile }
