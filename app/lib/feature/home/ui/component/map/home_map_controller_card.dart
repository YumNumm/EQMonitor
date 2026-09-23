import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/services.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class HomeMapControllerCard extends StatelessWidget {
  const new({
    super.key,
    this.onLayerButtonTap,
    this.onLocationButtonTap,
    this.isLocationButtonEnabled = true,
    this.onDebugButtonTap,
    this.onLabelDebugButtonTap,
  });

  final void Function()? onLayerButtonTap;
  final void Function()? onLocationButtonTap;
  final bool isLocationButtonEnabled;
  final void Function()? onDebugButtonTap;
  final void Function()? onLabelDebugButtonTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final divider = M3EFloatingToolbarDivider(
      orientation: .horizontal,
      color: colorTheme.outlineVariant,
    );

    return Padding(
      padding: CardTheme.of(context).margin ?? const EdgeInsets.all(4),
      child: M3EVerticalFloatingToolbar(
        expanded: true,
        decoration: M3EFloatingToolbarDecoration(
          colors: M3EFloatingToolbarDefaults.standardColors(context).copyWith(
            toolbarContainerColor: colorTheme.surfaceContainerHigh.withValues(
              alpha: 0.92,
            ),
          ),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(designSystem.shape.md),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
          expandedShadowElevation: 0,
          collapsedShadowElevation: 0,
        ),
        content: Column(
          mainAxisSize: .min,
          children: [
            _MapToolbarButton(
              icon: Icons.layers_rounded,
              tooltip: '地図レイヤー設定',
              onPressed: onLayerButtonTap,
            ),
            divider,
            _MapToolbarButton(
              icon: Icons.home_rounded,
              tooltip: 'ホームの表示範囲に戻す',
              enabled: isLocationButtonEnabled,
              onPressed: onLocationButtonTap,
            ),
            if (onLabelDebugButtonTap != null) ...[
              divider,
              _MapToolbarButton(
                icon: Icons.label_rounded,
                tooltip: '地図ラベルをデバッグ',
                onPressed: onLabelDebugButtonTap,
              ),
            ],
            if (onDebugButtonTap != null) ...[
              divider,
              _MapToolbarButton(
                icon: Icons.bug_report_rounded,
                tooltip: '地図をデバッグ',
                onPressed: onDebugButtonTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MapToolbarButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.enabled = true,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon),
    tooltip: tooltip,
    enableFeedback: false,
    onPressed: enabled
        ? () async {
            await HapticFeedback.lightImpact();
            onPressed?.call();
          }
        : null,
  );
}
