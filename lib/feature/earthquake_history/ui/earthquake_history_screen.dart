import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryScreen extends StatelessWidget {
  const EarthquakeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('地震履歴'),
            pinned: true,
          ),
          _SliverListBody(),
        ],
      ),
    );
  }
}

class _SliverListBody extends ConsumerWidget {
  const _SliverListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(earthquakeHistoryNotifierProvider);
    return state.when(
      loading: () => const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      error: (error, stackTrace) => SliverFillRemaining(
        // FIXME(YumNumm): エラーハンドリング
        child: Center(
          child: Text('Error: $error'),
        ),
      ),
      data: (data) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final item = data[index];
            return ListTile(
              title: Text(item.headline.toString()),
              subtitle: Text(item.maxIntensityRegionIds.toString()),
            );
          },
          childCount: data.length,
        ),
      ),
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
    );
  }
}
