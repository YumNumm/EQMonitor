import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_tuning_resolver.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_tuning.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_settings.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class DebugShakeDetectionEnginePage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(shakeDetectionCurrentSettingsProvider);
    final resolver = ref.watch(shakeDetectionTuningResolverProvider);
    final frame = ref.watch(deviceShakeDetectionProvider);
    final events = frame?.events ?? const [];

    Future<void> save(ShakeDetectionSettingsModel model) =>
        ref.read(shakeDetectionSettingsProvider.notifier).save(model);

    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知エンジン')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('検知の状態'),
            subtitle: Text(
              frame == null
                  ? '検知していません（強震モニタが地上の震度を表示している間だけ動作します）'
                  : '最終フレーム: ${frame.observedAt.toIso8601String()}\n'
                        '確定 ${events.where((e) => e.isConfirmed).length} 件 / '
                        '未確定 ${events.where((e) => !e.isConfirmed).length} 件',
            ),
            leading: const Icon(Icons.sensors_rounded),
          ),
          SwitchListTile(
            title: const Text('端末内で揺れを検知する'),
            subtitle: const Text('強震モニタの画像から検知し、ホームの地図とカードに表示'),
            value: settings.isEnabled,
            onChanged: (value) async =>
                save(settings.copyWith(isEnabled: value)),
          ),
          SwitchListTile(
            title: const Text('直近のフレームで履歴を作り直す'),
            subtitle: const Text('起動・復帰の直後に直近の画像を裏で取得し、連続して動いていた場合に近い状態にする'),
            value: settings.isBackfillEnabled,
            onChanged: (value) async =>
                save(settings.copyWith(isBackfillEnabled: value)),
          ),
          const Divider(),
          ListTile(
            title: const Text('パラメータ'),
            subtitle: Text(
              '変更すると次のフレームで検知をやり直します。'
              '変更済み: ${settings.parameterOverrides.length} 件',
            ),
          ),
          for (final tunable in ShakeDetectionTunable.values)
            ListTile(
              title: Text(tunable.label),
              subtitle: Text(
                '初期値: ${_format(tunable, resolver.defaultValue(tunable))}',
              ),
              trailing: Text(
                _format(
                  tunable,
                  resolver.value(tunable, settings.parameterOverrides),
                ),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: settings.parameterOverrides.containsKey(tunable.name)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
              onTap: () async {
                final defaultValue = resolver.defaultValue(tunable);
                final value = await showDialog<double>(
                  context: context,
                  builder: (context) => _ValueDialog(
                    tunable: tunable,
                    initialText: _format(
                      tunable,
                      resolver.value(tunable, settings.parameterOverrides),
                    ),
                    defaultValue: defaultValue,
                  ),
                );
                if (value == null) {
                  return;
                }
                await save(
                  settings.copyWith(
                    parameterOverrides: {
                      for (final entry in settings.parameterOverrides.entries)
                        if (entry.key != tunable.name) entry.key: entry.value,
                      if (value != defaultValue) tunable.name: value,
                    },
                  ),
                );
              },
            ),
          const Divider(),
          ListTile(
            title: const Text('パラメータをすべて初期値に戻す'),
            leading: const Icon(Icons.restart_alt),
            enabled: settings.parameterOverrides.isNotEmpty,
            onTap: () async =>
                save(settings.copyWith(parameterOverrides: const {})),
          ),
        ],
      ),
    );
  }

  String _format(ShakeDetectionTunable tunable, double value) =>
      tunable.isInteger ? value.round().toString() : value.toString();
}

class _ValueDialog extends HookWidget {
  const new({
    required this.tunable,
    required this.initialText,
    required this.defaultValue,
  });

  final ShakeDetectionTunable tunable;
  final String initialText;
  final double defaultValue;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialText);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return AlertDialog(
      title: Text(tunable.label),
      scrollable: true,
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (text) {
            final value = double.tryParse(text ?? '');
            if (value == null || !value.isFinite) {
              return '数値を入力してください';
            }
            if (tunable.isInteger &&
                (value != value.roundToDouble() || value < 0)) {
              return '0 以上の整数を入力してください';
            }
            return null;
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(defaultValue),
          child: const Text('初期値に戻す'),
        ),
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: () {
            if (formKey.currentState?.validate() != true) {
              return;
            }
            Navigator.of(context).pop(double.tryParse(controller.text));
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
