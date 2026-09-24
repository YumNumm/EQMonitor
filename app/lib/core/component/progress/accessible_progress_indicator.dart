import 'dart:ui' show SemanticsRole;

import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class AccessibleCircularProgressIndicator extends StatelessWidget {
  const new({
    this.value,
    this.color,
    this.valueColor,
    this.strokeWidth = 4,
    this.semanticsLabel = '読み込み中',
    super.key,
  });

  final double? value;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double strokeWidth;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final progress = value;
    return Semantics(
      label: semanticsLabel,
      role: progress == null
          ? SemanticsRole.loadingSpinner
          : SemanticsRole.progressBar,
      minValue: progress == null ? null : '0',
      maxValue: progress == null ? null : '100',
      value: progress == null
          ? null
          : '${(progress.clamp(0, 1) * 100).round()}%',
      child: M3ECircularProgressIndicator(
        value: value,
        color: color,
        valueColor: valueColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class AccessibleLinearProgressIndicator extends StatelessWidget {
  const new({
    this.value,
    this.minHeight = 4,
    this.semanticsLabel = '読み込み中',
    super.key,
  });

  final double? value;
  final double minHeight;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final progress = value;
    return Semantics(
      label: semanticsLabel,
      role: progress == null ? .loadingSpinner : .progressBar,
      minValue: progress == null ? null : '0',
      maxValue: progress == null ? null : '100',
      value: progress == null
          ? null
          : '${(progress.clamp(0, 1) * 100).round()}%',
      child: M3ELinearProgressIndicator(value: value, minHeight: minHeight),
    );
  }
}
