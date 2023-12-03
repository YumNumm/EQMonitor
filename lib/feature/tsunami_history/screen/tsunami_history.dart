import 'dart:convert';

import 'package:eqmonitor/feature/tsunami_history/viewmodel/tsunami_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TsunamiHistoryScreen extends HookConsumerWidget {
  const TsunamiHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tsunamiHistoryViewModelProvider);
    useEffect(() {
      WidgetsBinding.instance.endOfFrame.then((_) {
        print('useEffect');
        ref.read(tsunamiHistoryViewModelProvider.notifier).loadIfNull();
      });
      return null;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('津波情報'),
      ),
      body: switch (state) {
        AsyncData(:final value) => ListView.builder(
            itemBuilder: (context, index) {
              final item = value[index];
              return ListTile(
                title:
                    Text(item.vtse41?.body?.comments?.warning?.text ?? 'null'),
                subtitle: Text(
                  const JsonEncoder.withIndent('  ').convert(item.toJson()),
                ),
              );
            },
            itemCount: value.length,
          ),
        AsyncError(:final error) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        _ => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      },
    );
  }
}
