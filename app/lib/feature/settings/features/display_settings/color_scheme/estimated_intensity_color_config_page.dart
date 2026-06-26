import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/estimated_intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EstimatedIntensityColorConfigPage extends HookConsumerWidget {
  const EstimatedIntensityColorConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(estimatedIntensityColorProvider);
    final messenger = ScaffoldMessenger.of(context);

    Future<void> importFromJsonText(String text) async {
      final result = await ref
          .read(estimatedIntensityColorProvider.notifier)
          .importFromJsonString(text);
      switch (result) {
        case Success<void, IntensityColorImportException>():
          messenger.showSnackBar(
            const SnackBar(content: Text('推計震度配色をインポートしました')),
          );
        case Failure<void, IntensityColorImportException>():
          messenger.showSnackBar(
            SnackBar(content: Text(result.exception.message)),
          );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('推計震度配色設定')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioGroup(
              onChanged: (value) async => ref
                  .read(estimatedIntensityColorProvider.notifier)
                  .update(value!),
              groupValue: state,
              child: Column(
                children: [
                  RadioListTile.adaptive(
                    value: IntensityColorModel.mapFillHighContrast(),
                    title: const Text('高コントラスト（WCAG準拠）'),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _IntensityPreview(
                        colorModel: IntensityColorModel.mapFillHighContrast(),
                      ),
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: IntensityColorModel.eqmonitor(),
                    title: const Text('EQMonitor'),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _IntensityPreview(
                        colorModel: IntensityColorModel.eqmonitor(),
                      ),
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: IntensityColorModel.jma(),
                    title: const Text('気象庁配色'),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _IntensityPreview(
                        colorModel: IntensityColorModel.jma(),
                      ),
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: IntensityColorModel.earthQuickly(),
                    title: const Text('EarthQuickly'),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _IntensityPreview(
                        colorModel: IntensityColorModel.earthQuickly(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'カスタム配色を編集',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.tonal(
                        onPressed: () async => ref
                            .read(estimatedIntensityColorProvider.notifier)
                            .update(IntensityColorModel.mapFillHighContrast()),
                        child: const Text('高コントラストを適用'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async => ref
                            .read(estimatedIntensityColorProvider.notifier)
                            .update(IntensityColorModel.eqmonitor()),
                        child: const Text('EQMonitorを適用'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async => ref
                            .read(estimatedIntensityColorProvider.notifier)
                            .update(IntensityColorModel.jma()),
                        child: const Text('気象庁配色を適用'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async => ref
                            .read(estimatedIntensityColorProvider.notifier)
                            .update(IntensityColorModel.earthQuickly()),
                        child: const Text('EarthQuicklyを適用'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...IntensityColorTarget.values.map(
                    (target) => _EditableIntensityTile(target: target),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'JSON入出力',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.tonal(
                        onPressed: () async {
                          final json = ref
                              .read(estimatedIntensityColorProvider.notifier)
                              .exportAsJsonString();
                          await Clipboard.setData(ClipboardData(text: json));
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('JSONをクリップボードにコピーしました'),
                            ),
                          );
                        },
                        child: const Text('クリップボードへエクスポート'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async {
                          final json = ref
                              .read(estimatedIntensityColorProvider.notifier)
                              .exportAsJsonString();
                          final path = await FilePicker.saveFile(
                            dialogTitle: '推計震度配色JSONを保存',
                            fileName: 'estimated_intensity_color.json',
                            type: .custom,
                            allowedExtensions: const ['json'],
                            bytes: utf8.encode(json),
                          );
                          if (path == null) {
                            return;
                          }
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('JSONを保存しました'),
                            ),
                          );
                        },
                        child: const Text('ファイルへエクスポート'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async {
                          final data = await Clipboard.getData(
                            Clipboard.kTextPlain,
                          );
                          final text = data?.text;
                          if (text == null || text.isEmpty) {
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('クリップボードにJSON文字列がありません'),
                              ),
                            );
                            return;
                          }
                          await importFromJsonText(text);
                        },
                        child: const Text('クリップボードからインポート'),
                      ),
                      FilledButton.tonal(
                        onPressed: () async {
                          final result = await FilePicker.pickFiles(
                            type: .custom,
                            allowedExtensions: const ['json'],
                          );
                          final files = result?.files;
                          if (files == null || files.isEmpty) {
                            return;
                          }
                          final file = files.first;
                          final bytes = await file.readAsBytes();
                          await importFromJsonText(
                            utf8.decode(bytes),
                          );
                          return;
                        },
                        child: const Text('ファイルからインポート'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: kFloatingActionButtonMargin * 4),
          ],
        ),
      ),
    );
  }
}

class _EditableIntensityTile extends HookConsumerWidget {
  const _EditableIntensityTile({required this.target});

  final IntensityColorTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(estimatedIntensityColorProvider);
    final textColor = model.fromTarget(target);
    return ListTile(
      key: ValueKey('estimated-intensity-row-${target.name}'),
      contentPadding: EdgeInsets.zero,
      leading: Container(
        key: ValueKey('estimated-intensity-bg-${target.name}'),
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: textColor.background,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(
          target.label,
          style: TextStyle(
            color: textColor.foreground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text('震度 ${target.label}'),
      trailing: FilledButton.tonal(
        onPressed: () async {
          final selected = await _showColorPickerDialog(
            context,
            textColor.background,
          );
          if (selected == null) {
            return;
          }
          final next = model.copyWithTargetBackground(target, selected);
          await ref
              .read(estimatedIntensityColorProvider.notifier)
              .update(next);
        },
        child: const Text('編集'),
      ),
    );
  }
}

Future<Color?> _showColorPickerDialog(
  BuildContext context,
  Color initialColor,
) {
  return showAdaptiveDialog<Color>(
    context: context,
    builder: (_) => HookBuilder(
      builder: (context) {
        final pickerColor = useState(initialColor);
        return AlertDialog.adaptive(
          title: const Text('背景色を選択'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor.value,
              onColorChanged: (color) => pickerColor.value = color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(pickerColor.value),
              child: const Text('適用'),
            ),
          ],
        );
      },
    ),
  );
}

class _IntensityPreview extends StatelessWidget {
  const _IntensityPreview({required this.colorModel});

  final IntensityColorModel colorModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        ...JmaIntensity.values
            .where((e) => e != JmaIntensity.unknown)
            .map(
              (e) => Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorModel.fromJmaIntensity(e).background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  e.label,
                  style: TextStyle(
                    color: colorModel.fromJmaIntensity(e).foreground,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
