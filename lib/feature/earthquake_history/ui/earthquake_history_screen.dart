import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryScreen extends StatelessWidget {
  const EarthquakeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text('地震履歴'),
            pinned: true,
          ),
        ],
        body: const _SliverListBody(),
      ),
    );
  }
}

class _SliverListBody extends ConsumerWidget {
  const _SliverListBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(earthquakeHistoryNotifierProvider);
    return RefreshIndicator(
      onRefresh: () async {
        final _ = ref.refresh(earthquakeHistoryNotifierProvider);
        await ref.read(earthquakeHistoryNotifierProvider.future);
      },
      child: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        error: (error, stackTrace) {
          if (error is EarthquakeParameterHasNotInitializedException) {
            final parameterState = ref.watch(jmaParameterProvider);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('観測点情報が初期化されていません'),
                  if (parameterState.isLoading)
                    const CircularProgressIndicator.adaptive()
                  else
                    FilledButton(
                      child: const Text('観測点情報を再取得'),
                      onPressed: () async =>
                          ref.invalidate(jmaParameterProvider),
                    ),
                ],
              ),
            );
          }
          return Center(
            child: Text('Error: $error'),
          );
        },
        data: (data) => ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return EarthquakeHistoryListTile(
              item: item,
              onTap: () {},
            );
          },
        ),
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
      ),
    );
  }
}
