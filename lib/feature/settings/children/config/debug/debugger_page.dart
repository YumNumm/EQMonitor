import 'package:eqmonitor/feature/home/component/sheet/debug_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebuggerPage extends ConsumerWidget {
  const DebuggerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debugger'),
      ),
      body: ListView(
        children: const [
          DebugWidget(),
        ],
      ),
    );
  }
}
