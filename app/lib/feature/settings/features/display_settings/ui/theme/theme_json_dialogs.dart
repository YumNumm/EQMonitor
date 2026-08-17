import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeImportExportSection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final themes = ref.watch(appThemeProvider).requireValue;

    Future<void> exportMode(ThemeBrightnessMode mode) async {
      final theme = switch (mode) {
        ThemeBrightnessMode.light => themes.lightTheme,
        ThemeBrightnessMode.dark => themes.darkTheme,
      };
      final json = ref.read(appThemeProvider.notifier).exportToJson(theme);
      await Clipboard.setData(ClipboardData(text: json));
      messenger.showSnackBar(
        const SnackBar(content: Text('JSONをクリップボードにコピーしました')),
      );
    }

    Future<void> showImportErrorDialog(String message) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: const Text('インポートに失敗しました'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('閉じる'),
            ),
          ],
        ),
      );
    }

    Future<void> showApplyModeDialog(AppTheme theme) async {
      final result = await showAdaptiveDialog<Set<ThemeBrightnessMode>>(
        context: context,
        builder: (dialogContext) => HookBuilder(
          builder: (context) {
            final state = useState<Set<ThemeBrightnessMode>>({...theme.modes});
            return AlertDialog.adaptive(
              title: const Text('適用先を選択'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: ThemeBrightnessMode.values
                    .where(theme.supportsMode)
                    .map(
                      (mode) => CheckboxListTile.adaptive(
                        value: state.value.contains(mode),
                        title: Text(mode.name),
                        onChanged: (checked) {
                          final next = {...state.value};
                          if (checked ?? false) {
                            next.add(mode);
                          } else {
                            next.remove(mode);
                          }
                          state.value = next;
                        },
                      ),
                    )
                    .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('キャンセル'),
                ),
                FilledButton(
                  onPressed: state.value.isEmpty
                      ? null
                      : () => Navigator.of(dialogContext).pop(state.value),
                  child: const Text('適用'),
                ),
              ],
            );
          },
        ),
      );
      if (result == null || result.isEmpty) {
        return;
      }
      for (final mode in result) {
        await ref.read(appThemeProvider.notifier).setThemeForMode(mode, theme);
      }
      messenger.showSnackBar(const SnackBar(content: Text('テーマを適用しました')));
    }

    Future<void> showImportDialog() async {
      final controller = TextEditingController();
      final text = await showAdaptiveDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: const Text('JSONをインポート'),
          content: TextField(
            controller: controller,
            maxLines: 8,
            decoration: const InputDecoration(hintText: 'テーマJSONを貼り付け'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: const Text('インポート'),
            ),
          ],
        ),
      );
      if (text == null || text.isEmpty) {
        return;
      }
      final result = ref.read(appThemeProvider.notifier).importFromJson(text);
      switch (result) {
        case Success<AppTheme, AppThemeImportException>():
          await showApplyModeDialog(result.value);
        case Failure<AppTheme, AppThemeImportException>():
          await showImportErrorDialog(result.exception.message);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FilledButton.tonal(
            onPressed: () => exportMode(ThemeBrightnessMode.light),
            child: const Text('ライトをエクスポート'),
          ),
          FilledButton.tonal(
            onPressed: () => exportMode(ThemeBrightnessMode.dark),
            child: const Text('ダークをエクスポート'),
          ),
          FilledButton.tonal(
            onPressed: showImportDialog,
            child: const Text('JSONをインポート'),
          ),
        ],
      ),
    );
  }
}
