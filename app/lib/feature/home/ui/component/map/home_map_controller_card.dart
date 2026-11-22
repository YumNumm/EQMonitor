import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/services.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const HomeMapControllerCard({
  super.key,
  final void Function()? onLayerButtonTap,
  final void Function()? onLocationButtonTap,
  final bool isLocationButtonEnabled = true,
  final void Function()? onDebugButtonTap,
  final void Function()? onLabelDebugButtonTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final divider = M3EFloatingToolbarDivider(
      orientation: .horizontal,
      color: colorTheme.outlineVariant,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainer,
        border: Border.all(
          color: colorTheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(designSystem.shape.card),
      ),
      child: Padding(
        padding: CardTheme.of(context).margin ?? const EdgeInsets.all(4),
        child: Column(
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

class const _MapToolbarButton({
  required final IconData icon,
  required final String tooltip,
  required final VoidCallback? onPressed,
  final bool enabled = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon),
    tooltip: tooltip,
    onPressed: enabled
        ? () async {
            await HapticFeedback.lightImpact();
            onPressed?.call();
          }
        : null,
  );
}
