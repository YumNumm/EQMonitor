import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.secondaryContainer;
    final textColor = colorScheme.onSecondaryContainer;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return switch (type) {
      _AppListTileType.switchListTile =>
        SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          shape: shape,
          tileColor: backgroundColor,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
          value: value!,
          onChanged: onChanged,
        ),
      _AppListTileType.listTile => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        shape: shape,
        tileColor: backgroundColor,
        textColor: textColor,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    };
  }
}

enum _AppListTileType { switchListTile, listTile }
