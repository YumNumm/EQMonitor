import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';

class NiedPage extends StatelessWidget {
  const NiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NIED'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('AQUAシステム'),
            subtitle: const Text('地震メカニズム解の速報解析システム'),
            leading: const Icon(Icons.waves),
            onTap: () async => const AquaRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
