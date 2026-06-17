import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugTsunamiDetailsPage extends HookConsumerWidget {
  const DebugTsunamiDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tsunami Details Debug')),
      body: _TsunamiListView(),
    );
  }
}

class _TsunamiListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _fetchTsunamiList(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final items = snapshot.data ?? <TsunamiState>[];
        if (items.isEmpty) {
          return const Center(child: Text('No tsunami events found'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.id),
              subtitle: Text(
                'Active: ${item.isActive} | '
                'Canceled: ${item.isCanceled} | '
                'Regions: ${item.forecastRegions.length}',
              ),
              onTap: () => TsunamiDetailsRoute(
                tsunamiId: item.id,
              ).push<void>(context),
            );
          },
        );
      },
    );
  }

  Future<List<TsunamiState>> _fetchTsunamiList(WidgetRef ref) async {
    final client = await ref.read(apiClientProvider.future);
    final response = await client.tsunami.getV2Tsunami(limit: '20');
    return response.data.items;
  }
}
