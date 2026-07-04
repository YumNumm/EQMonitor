import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';

class NiedPage extends StatelessWidget {
  const NiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NIED')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('AQUAシステム'),
            subtitle: const Text('地震メカニズム解の速報解析システム'),
            leading: const Icon(Icons.waves),
            onTap: () async => const AquaRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('F-net'),
            subtitle: const Text('広帯域地震観測網'),
            leading: const Icon(Icons.sensors),
            onTap: () async => const FnetRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('K-NET/KiK-net'),
            subtitle: const Text('強震観測網 波形データ'),
            leading: const Icon(Icons.show_chart),
            onTap: () async => const KnetWaveformRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('Hi-net 一元化震源ビューア'),
            subtitle: const Text('デバッグ専用・二次配布禁止データのため非公開'),
            leading: const Icon(Icons.warning_amber),
            onTap: () async => const HinetSeismicityRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
