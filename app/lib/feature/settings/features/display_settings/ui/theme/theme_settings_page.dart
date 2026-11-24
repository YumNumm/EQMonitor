import 'dart:async';

import 'package:m3e_core/m3e_core.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/theme/provider/theme_presets_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_json_dialogs.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class const ThemeSettingsPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('テーマ設定')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SettingsSectionHeader(text: 'ライト用テーマ'),
              _ModeSection(mode: ThemeBrightnessMode.light),
              SettingsSectionHeader(text: 'ダーク用テーマ'),
              _ModeSection(mode: ThemeBrightnessMode.dark),
              SettingsSectionHeader(text: 'JSON 入出力'),
              ThemeImportExportSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class const _ModeSection({required final ThemeBrightnessMode mode})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = ref.watch(appThemeProvider).requireValue;
    final currentTheme = switch (mode) {
      .light => themes.lightTheme,
      .dark => themes.darkTheme,
    };
    final presets = ref.watch(themePresetsProvider);
    final Brightness brightness = switch (mode) {
      .light => .light,
      .dark => .dark,
    };

    return BorderedContainer(
      margin: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            currentTheme.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _ThemePreview(colorSet: currentTheme.colorSetFor(brightness)),
          const SizedBox(height: 8),
          RadioGroup<AppTheme>(
            groupValue: currentTheme,
            onChanged: (preset) async {
              if (preset == null) {
                return;
              }
              unawaited(HapticFeedback.selectionClick());
              await ref
                  .read(appThemeProvider.notifier)
                  .setThemeForMode(mode, preset);
            },
            child: Column(
              children: presets
                  .map(
                    (preset) => RadioListTile<AppTheme>.adaptive(
                      contentPadding: .zero,
                      title: Text(preset.name),
                      value: preset,
                    ),
                  )
                  .toList(),
            ),
          ),
          Align(
            alignment: .centerRight,
            child: M3EFilledButton.tonal(
              onPressed: () async =>
                  ThemeEditorRoute(mode: mode.name).push<void>(context),
              child: const Text('編集'),
            ),
          ),
        ],
      ),
    );
  }
}

class const _ThemePreview({required final ThemeColorSet colorSet})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          DesignSystemThemeExtension(
            colorTheme: colorSet,
            spacing: .standard(),
            shape: .standard(),
            typography: .fromColorTheme(colorSet),
          ),
        ],
      ),
      child: Row(
        spacing: 8,
        children: [
          _Swatch(color: colorSet.primary, label: 'Primary'),
          _Swatch(color: colorSet.surface, label: 'Surface'),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                children: JmaIntensity.values
                    .map(
                      (e) => Padding(
                        padding: const .symmetric(horizontal: 2),
                        child: JmaIntensityIcon(
                          intensity: e,
                          type: .small,
                          size: 24,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Swatch({required final Color color, required final String label})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: .circle,
            border: Border.all(color: context.designSystem.colorTheme.outline),
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
