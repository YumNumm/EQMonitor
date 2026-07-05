import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeEditorPage extends ConsumerWidget {
  const ThemeEditorPage({required this.mode, super.key});

  final ThemeBrightnessMode mode;

  static const _flatCategories = [
    ThemeColorFieldCategory.primary,
    ThemeColorFieldCategory.secondary,
    ThemeColorFieldCategory.tertiary,
    ThemeColorFieldCategory.error,
    ThemeColorFieldCategory.surface,
    ThemeColorFieldCategory.status,
  ];

  static String _categoryLabel(ThemeColorFieldCategory category) =>
      switch (category) {
        ThemeColorFieldCategory.primary => 'プライマリ',
        ThemeColorFieldCategory.secondary => 'セカンダリ',
        ThemeColorFieldCategory.tertiary => 'ターシャリ',
        ThemeColorFieldCategory.error => 'エラー',
        ThemeColorFieldCategory.surface => 'サーフェス',
        ThemeColorFieldCategory.status => 'ステータス',
        ThemeColorFieldCategory.map => 'マップ',
      };

  static const _mapCategory = ThemeColorFieldCategory.map;

  static Future<Color?> _pickColor(BuildContext context, Color initial) {
    return showAdaptiveDialog<Color>(
      context: context,
      builder: (dialogContext) => _ColorPickerDialog(initial: initial),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSet = ref.watch(themeEditorControllerProvider(mode));
    final controller = ref.read(themeEditorControllerProvider(mode).notifier);

    return Scaffold(
      appBar: AppBar(title: Text('テーマ編集 (${mode.name})')),
      body: ListView(
        children: [
          ..._flatCategories.map(
            (category) => ExpansionTile(
              title: Text(_categoryLabel(category)),
              children: ThemeColorFieldDefs.all
                  .where((def) => def.category == category)
                  .map(
                    (def) => _ColorFieldTile(
                      def: def,
                      colorSet: colorSet,
                      onChanged: (color) => controller.updateField(def, color),
                    ),
                  )
                  .toList(),
            ),
          ),
          ExpansionTile(
            title: Text(_categoryLabel(_mapCategory)),
            children: ThemeColorFieldDefs.all
                .where((def) => def.category == _mapCategory)
                .map(
                  (def) => _ColorFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (color) => controller.updateField(def, color),
                  ),
                )
                .toList(),
          ),
          ExpansionTile(
            title: const Text('震度配色'),
            children: IntensityFieldDefs.all
                .where((def) => def.group == IntensityFieldGroup.intensity)
                .map(
                  (def) => _IntensityFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (entry) =>
                        controller.updateIntensityEntry(def, entry),
                  ),
                )
                .toList(),
          ),
          ExpansionTile(
            title: const Text('推計震度配色'),
            children: IntensityFieldDefs.all
                .where(
                  (def) => def.group == IntensityFieldGroup.estimatedIntensity,
                )
                .map(
                  (def) => _IntensityFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (entry) =>
                        controller.updateIntensityEntry(def, entry),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ColorFieldTile extends StatelessWidget {
  const _ColorFieldTile({
    required this.def,
    required this.colorSet,
    required this.onChanged,
  });

  final ThemeColorFieldDef def;
  final ThemeColorSet colorSet;
  final void Function(Color color) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey('theme_color_field_${def.label}'),
      title: Text(def.label),
      trailing: GestureDetector(
        onTap: () async {
          final picked = await ThemeEditorPage._pickColor(
            context,
            def.getter(colorSet),
          );
          if (picked == null) {
            return;
          }
          onChanged(picked);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: def.getter(colorSet),
            shape: BoxShape.circle,
            border: Border.all(color: context.designSystem.colorTheme.outline),
          ),
        ),
      ),
    );
  }
}

class _IntensityFieldTile extends StatelessWidget {
  const _IntensityFieldTile({
    required this.def,
    required this.colorSet,
    required this.onChanged,
  });

  final IntensityFieldDef def;
  final ThemeColorSet colorSet;
  final void Function(IntensityColorEntry entry) onChanged;

  @override
  Widget build(BuildContext context) {
    final entry = def.entryGetter(colorSet);
    final keySuffix = def.label;

    return ListTile(
      title: Text(def.label),
      subtitle: Row(
        children: [
          const Text('文字色: '),
          SegmentedButton<bool>(
            key: ValueKey('intensity-fg-mode-$keySuffix'),
            segments: const [
              ButtonSegment(value: true, label: Text('自動')),
              ButtonSegment(value: false, label: Text('手動')),
            ],
            selected: {entry.foreground is IntensityTextColorAuto},
            onSelectionChanged: (selection) {
              final isAuto = selection.first;
              onChanged(
                entry.copyWith(
                  foreground: isAuto
                      ? const IntensityTextColor.auto()
                      : IntensityTextColor.manual(
                          color: entry.resolvedForeground,
                        ),
                ),
              );
            },
          ),
          if (entry.foreground case IntensityTextColorManual(:final color))
            GestureDetector(
              key: ValueKey('intensity-fg-manual-$keySuffix'),
              onTap: () async {
                final picked = await ThemeEditorPage._pickColor(context, color);
                if (picked == null) {
                  return;
                }
                onChanged(
                  entry.copyWith(
                    foreground: IntensityTextColor.manual(color: picked),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.designSystem.colorTheme.outline,
                  ),
                ),
              ),
            ),
        ],
      ),
      trailing: GestureDetector(
        key: ValueKey('intensity-bg-$keySuffix'),
        onTap: () async {
          final picked = await ThemeEditorPage._pickColor(
            context,
            entry.background,
          );
          if (picked == null) {
            return;
          }
          onChanged(entry.copyWith(background: picked));
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: entry.background,
            shape: BoxShape.circle,
            border: Border.all(color: context.designSystem.colorTheme.outline),
          ),
        ),
      ),
    );
  }
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({required this.initial});

  final Color initial;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _current = widget.initial;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('色を選択'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _current,
          onColorChanged: (color) => setState(() => _current = color),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_current),
          child: const Text('適用'),
        ),
      ],
    );
  }
}
