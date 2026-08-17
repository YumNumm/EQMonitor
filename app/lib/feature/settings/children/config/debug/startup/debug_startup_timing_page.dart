import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugStartupTimingPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timings = ref.watch(startupProfilerProvider).timingsMicros;
    final entries = timings.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    return Scaffold(
      appBar: AppBar(title: const Text('Startup Timing')),
      body: ListView(
        children: [
          for (final entry in entries)
            ListTile(
              title: Text(entry.key),
              trailing: Text('${(entry.value / 1000).toStringAsFixed(2)} ms'),
            ),
          if (entries.isEmpty) const ListTile(title: Text('計測データがありません')),
        ],
      ),
    );
  }
}
