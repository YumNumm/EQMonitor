import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'information.viewmodel.dart';

class InformationView extends HookConsumerWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(informationViewModel);
    final appBar = AppBar(
      title: const Text('お知らせ'),
    );

    return Scaffold(
      appBar: appBar,
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (items) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (notification.metrics.extentAfter == 0 &&
                  (vm.value?.isNotEmpty ?? false)) {
                ref.read(informationViewModel.notifier).fetch();
                return true;
              }
              return false;
            },
            child: Scrollbar(
              child: ListView.builder(
                itemCount: items.length + (vm.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final item = items[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.body),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
