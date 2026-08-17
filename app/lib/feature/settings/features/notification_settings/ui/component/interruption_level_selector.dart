import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:flutter/material.dart';

const currentLocationLevels = [
  InterruptionLevel.passive,
  InterruptionLevel.active,
  InterruptionLevel.timeSensitive,
  InterruptionLevel.critical,
];

const nationwideLevels = [
  InterruptionLevel.passive,
  InterruptionLevel.active,
  InterruptionLevel.timeSensitive,
];

class InterruptionLevelSelector extends StatelessWidget {
  const InterruptionLevelSelector({
    required this.title,
    required this.value,
    required this.levels,
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final String title;
  final InterruptionLevel value;
  final List<InterruptionLevel> levels;
  final bool enabled;
  final Future<void> Function(InterruptionLevel value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(text: title),
        RadioGroup<InterruptionLevel>(
          groupValue: value,
          onChanged: (selected) async {
            if (selected != null && enabled) {
              await onChanged(selected);
            }
          },
          child: Column(
            children: [
              for (final level in levels)
                RadioListTile<InterruptionLevel>(
                  title: Text(switch (level) {
                    .passive => 'パッシブ',
                    .active => 'アクティブ',
                    .timeSensitive => 'タイムセンシティブ',
                    .critical => '重大な通知',
                  }),
                  value: level,
                  enabled: enabled,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
