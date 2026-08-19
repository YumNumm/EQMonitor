// The Scene spike stays internal and is exercised through this manual smoke
// harness.
// ignore_for_file: implementation_imports

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_remount_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() => runApp(const EqmonitorMapExampleApp());

class EqmonitorMapExampleApp extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final remountOwner = useMemoized(FlutterSceneSpikeRemountOwner.create);
    useEffect(() => remountOwner.dispose, [remountOwner]);
    return MaterialApp(
      title: 'EQMonitor Map Scene Spike',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('EQMonitor Map Scene Spike')),
        body: FlutterSceneSpikeView(remountOwner: remountOwner),
      ),
    );
  }
}
