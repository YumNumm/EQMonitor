import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class AppListTile extends StatelessWidget {
  factory AppListTile.switchListTile({
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

  factory AppListTile.listTile({
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

  const AppListTile._({
    required this.title,
    required this.subtitle,
    required this.type,
    this.value,
    this.onChanged,
    this.onTap,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final bool? value;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;
  final void Function()? onTap;
  final Widget? trailing;
  // ignore: library_private_types_in_public_api
  final _AppListTileType type;

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
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    };
  }
}

enum _AppListTileType { switchListTile, listTile }
