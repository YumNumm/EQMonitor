import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/eew_estimated_intensity_layer_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/eew_hypocenter_symbol_layer_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/eew_ps_wave_layer_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/kyoshin_monitor_layer_debug_page.dart';
import 'package:flutter/material.dart';

class LayerDebugPage extends StatelessWidget {
  const LayerDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('レイヤーデバッグ')),
      body: ListView(children: const [_LayerDebugList()]),
    );
  }
}

class _LayerDebugList extends StatelessWidget {
  const _LayerDebugList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.6),
          width: 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(title: 'レイヤーデバッグ'),
            ListTile(
              title: const Text('強震モニタレイヤー'),
              subtitle: const Text('KyoshinMonitorLayer'),
              leading: const Icon(Icons.layers),
              onTap:
                  () async => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder:
                          (context) => const KyoshinMonitorLayerDebugPage(),
                    ),
                  ),
            ),
            ListTile(
              title: const Text('EEW震源シンボルレイヤー'),
              subtitle: const Text('EewHypocenterSymbolLayer'),
              leading: const Icon(Icons.layers),
              onTap:
                  () async => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder:
                          (context) =>
                              const EewHypocenterSymbolLayerDebugPage(),
                    ),
                  ),
            ),
            ListTile(
              title: const Text('EEW P波・S波レイヤー'),
              subtitle: const Text('EewPsWaveLayer'),
              leading: const Icon(Icons.layers),
              onTap:
                  () async => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (context) => const EewPsWaveLayerDebugPage(),
                    ),
                  ),
            ),
            ListTile(
              title: const Text('EEW予想震度レイヤー'),
              subtitle: const Text('EewEstimatedIntensityLayer'),
              leading: const Icon(Icons.layers),
              onTap:
                  () async => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder:
                          (context) =>
                              const EewEstimatedIntensityLayerDebugPage(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
