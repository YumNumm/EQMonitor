import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';

const _flutterSceneRevision = '695c954f237fabef65d49fa7199002851d2dcd88';

void main() => runApp(const EqmonitorMapExampleApp());

class EqmonitorMapExampleApp extends StatelessWidget {
  const EqmonitorMapExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Package: ${eqmonitorMapLibrary.packageName}'),
              const SizedBox(height: 16),
              const SelectableText(
                'Flutter Scene revision\n$_flutterSceneRevision',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
