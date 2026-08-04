import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';

class EqmonitorMapDebugPage extends StatelessWidget {
  const EqmonitorMapDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EQMonitor Map (Flutter Scene)')),
      body: const BaseMapMaterialPreflightView(),
    );
  }
}
