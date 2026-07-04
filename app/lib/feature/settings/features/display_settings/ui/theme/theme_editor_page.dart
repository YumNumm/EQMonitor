import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
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
        ThemeColorFieldCategory.primary => 'Primary',
        ThemeColorFieldCategory.secondary => 'Secondary',
        ThemeColorFieldCategory.tertiary => 'Tertiary',
        ThemeColorFieldCategory.error => 'Error',
        ThemeColorFieldCategory.surface => 'Surface',
        ThemeColorFieldCategory.status => 'Status',
        ThemeColorFieldCategory.map => 'Map',
      };

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
        children: _flatCategories.map((category) {
          final defs = ThemeColorFieldDefs.all
              .where((def) => def.category == category)
              .toList();
          return ExpansionTile(
            title: Text(_categoryLabel(category)),
            children: defs
                .map(
                  (def) => ListTile(
                    key: ValueKey('theme_color_field_${def.label}'),
                    title: Text(def.label),
                    trailing: GestureDetector(
                      onTap: () async {
                        final picked = await _pickColor(
                          context,
                          def.getter(colorSet),
                        );
                        if (picked == null) {
                          return;
                        }
                        await controller.updateField(def, picked);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: def.getter(colorSet),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.designSystem.colorTheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }).toList(),
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
