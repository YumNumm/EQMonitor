import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// [HomeEarthquakeHistoryScope] の表示用ラベルとアイコン。
extension HomeEarthquakeHistoryScopeDisplay on HomeEarthquakeHistoryScope {
  String get label => switch (this) {
    .nationwide => '全国',
    .currentLocation => '現在地',
    .custom => '指定地域',
  };

  IconData get icon => switch (this) {
    .nationwide => Icons.public_rounded,
    .currentLocation => Icons.my_location_rounded,
    .custom => Icons.place_outlined,
  };
}

/// 地震履歴カードの表示範囲を切り替えるチップ。
///
/// タップでメニューを開き、全国 / 現在地 / 指定地域を選択する。
/// [onEditRegion] を渡した場合は、指定地域の選び直しもメニューから行える。
class HomeScopeSelector extends StatelessWidget {
  const new({
    required this.scope,
    required this.onScopeChanged,
    this.onEditRegion,
    this.locationName,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;
  final VoidCallback? onEditRegion;

  /// 解決済みの地域名。チップにはこれを優先して表示する。
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final typography = designSystem.typography;

    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStateProperty.all(.zero),
        backgroundColor: WidgetStatePropertyAll(colorTheme.surfaceContainerLow),
        shape: WidgetStateProperty.all(
          RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.md),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
        ),
      ),
      menuChildren: [
        for (final value in HomeEarthquakeHistoryScope.values)
          MenuItemButton(
            leadingIcon: Icon(value.icon, size: 20),
            trailingIcon: value == scope
                ? Icon(Icons.check_rounded, size: 20, color: colorTheme.primary)
                : null,
            onPressed: () => onScopeChanged(value),
            child: Text(value.label, style: typography.bodyLarge),
          ),
        if (onEditRegion case final onEditRegion?) ...[
          const Divider(height: 1),
          MenuItemButton(
            leadingIcon: const Icon(Icons.edit_location_alt_outlined, size: 20),
            onPressed: onEditRegion,
            child: Text('地域を再選択', style: typography.bodyLarge),
          ),
        ],
      ],
      builder: (context, controller, child) => _ScopeChip(
        scope: scope,
        locationName: locationName,
        onTap: () {
          unawaited(HapticFeedback.lightImpact());
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
      ),
    );
  }
}

class _ScopeChip extends StatelessWidget {
  const new({required this.scope, required this.onTap, this.locationName});

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onTap;
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Material(
      color: colorTheme.surfaceContainerLow,
      shape: StadiumBorder(side: BorderSide(color: colorTheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.sm,
          ),
          child: Row(
            mainAxisSize: .min,
            spacing: spacing.xs,
            children: [
              Icon(scope.icon, size: 16, color: colorTheme.onSurfaceVariant),
              Flexible(
                child: Text(
                  locationName ?? scope.label,
                  style: designSystem.typography.labelLarge,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              Icon(
                Icons.expand_more_rounded,
                size: 18,
                color: colorTheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
