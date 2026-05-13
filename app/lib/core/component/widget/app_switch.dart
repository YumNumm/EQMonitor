import 'dart:async';

import 'package:cue/cue.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppSwitch extends HookWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final shape = designSystem.shape;
    final theme = Theme.of(context);
    final isEnabled = onChanged != null;

    final offThumbColor = color.backgroundSubtle;
    const onThumbColor = Color(0xFFC9D8F8);
    const offIconColor = Color(0xFFC9D8F8);
    const onIconColor = Color(0xFF48678F);

    return Opacity(
      opacity: isEnabled ? 1 : 0.56,
      child: Semantics(
        button: true,
        enabled: isEnabled,
        toggled: value,
        child: Material(
          color: Colors.transparent,
          child: Listener(
            onPointerDown: isEnabled
                ? (_) {
                    pressed.value = true;
                  }
                : null,
            onPointerUp: isEnabled
                ? (_) {
                    pressed.value = false;
                  }
                : null,
            onPointerCancel: isEnabled
                ? (_) {
                    pressed.value = false;
                  }
                : null,
            child: InkResponse(
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              radius: 28,
              borderRadius: BorderRadius.circular(shape.pill),
              onTap: isEnabled
                  ? () {
                      unawaited(HapticFeedback.selectionClick());
                      onChanged?.call(!value);
                    }
                  : null,
              child: Cue.onToggle(
                toggled: value,
                motion: const .smooth(),
                reverseMotion: const .snappy(),
                child: SizedBox(
                  width: 60,
                  height: 36,
                  child: Actor(
                    acts: [
                      .decorate(
                        color: .tween(
                          color.surfaceCard,
                          color.surfaceEmphasis,
                        ),
                        borderRadius: .fixed(
                          BorderRadius.circular(shape.pill),
                        ),
                        border: .tween(
                          Border.all(
                            color: color.outlineSoft,
                            width: 2,
                          ),
                          Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.5,
                            ),
                            width: 0,
                          ),
                        ),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Actor(
                        acts: const [
                          .align(
                            from: Alignment.centerLeft,
                            to: Alignment.centerRight,
                          ),
                        ],
                        child: Cue.onToggle(
                          toggled: pressed.value,
                          motion: const .snappy(),
                          reverseMotion: const .snappy(),
                          child: Actor(
                            acts: const [
                              .scale(
                                from: 1,
                                to: 1.12,
                              ),
                            ],
                            child: Actor(
                              acts: const [
                                .scale(
                                  from: 0.92,
                                  motion: .bouncy(),
                                ),
                              ],
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: value ? onThumbColor : offThumbColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.16,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: SizedBox.square(
                                  dimension: 28,
                                  child: Center(
                                    child: Cue.onToggle(
                                      toggled: value,
                                      motion: const .snappy(),
                                      reverseMotion: const .snappy(),
                                      acts: const [
                                        .scale(from: 0.6),
                                        .fadeIn(from: 0.3),
                                      ],
                                      child: Icon(
                                        value
                                            ? Icons.check_rounded
                                            : Icons.close_rounded,
                                        size: 16,
                                        color: value
                                            ? onIconColor
                                            : offIconColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppSwitchListTile extends StatelessWidget {
  const AppSwitchListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.subtitle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.shape,
    this.tileColor,
    this.textColor,
    this.visualDensity,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final EdgeInsetsGeometry contentPadding;
  final ShapeBorder? shape;
  final Color? tileColor;
  final Color? textColor;
  final VisualDensity? visualDensity;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final trailingWidgets = <Widget>[
      ?trailing,
      AppSwitch(value: value, onChanged: onChanged),
    ];

    return ListTile(
      onTap: onChanged == null ? null : () => onChanged?.call(!value),
      contentPadding: contentPadding,
      shape: shape,
      tileColor: tileColor,
      textColor: textColor,
      visualDensity: visualDensity,
      title: Text(title),
      subtitle: switch (subtitle) {
        final s? => Text(s),
        null => null,
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < trailingWidgets.length; index++) ...[
            if (index > 0) const SizedBox(width: 8),
            trailingWidgets[index],
          ],
        ],
      ),
    );
  }
}
