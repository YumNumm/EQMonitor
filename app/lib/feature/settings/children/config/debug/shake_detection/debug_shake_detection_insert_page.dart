import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugShakeDetectionInsertPage extends ConsumerWidget {
  const DebugShakeDetectionInsertPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlay = ref.watch(shakeDetectionDebugOverlayProvider);
    final presets = const ShakeDetectionDebugPresetFactory().presets;

    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知を挿入')),
      body: ListView(
        children: [
          ListTile(
            title: Text('デバッグイベント: ${overlay.length} 件'),
            subtitle: const Text('ホーム地図・カードに本番データとマージして表示'),
          ),
          for (final preset in presets)
            ListTile(
              title: Text(preset.title),
              subtitle: Text(preset.description),
              trailing: const Icon(Icons.add),
              onTap: () {
                ref
                    .read(shakeDetectionDebugOverlayProvider.notifier)
                    .insertPreset(id: preset.id);
              },
            ),
          const Divider(),
          ListTile(
            title: const Text('すべてクリア'),
            leading: const Icon(Icons.clear_all),
            enabled: overlay.isNotEmpty,
            onTap: overlay.isEmpty
                ? null
                : () {
                    ref
                        .read(shakeDetectionDebugOverlayProvider.notifier)
                        .clear();
                  },
          ),
        ],
      ),
    );
  }
}
