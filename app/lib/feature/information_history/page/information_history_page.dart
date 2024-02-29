import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/information_history/viewmodel/information_history_view_model.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class InformationHistoryPage extends HookConsumerWidget {
  const InformationHistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(informationHistoryViewModelProvider);
    final scrollController = PrimaryScrollController.of(context);
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) {
            scrollController.addListener(
              () => ref
                  .read(informationHistoryViewModelProvider.notifier)
                  .onScrollPositionChanged(
                    scrollController,
                  ),
            );
            ref
                .read(informationHistoryViewModelProvider.notifier)
                .updateIfNull();
          },
        );
        return null;
      },
    );
    final body = PrimaryScrollController(
      controller: scrollController,
      child: CustomScrollView(
        primary: true,
        slivers: [
          const SliverAppBar.medium(
            title: Text('地震・津波に関するお知らせ'),
          ),
          state?.whenOrNull(
                data: (data) => _InformationDataView(data: data),
                error: (error, stackTrace) => SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'お知らせの取得中にエラーが発生しました',
                      ),
                      Text(error.toString()),
                      FilledButton.tonal(
                        onPressed: () async => ref
                            .read(
                              informationHistoryViewModelProvider.notifier,
                            )
                            .update(
                              loadMore: false,
                            ),
                        child: const Text('再読み込み'),
                      ),
                    ],
                  ),
                ),
              ) ??
              const _Loading(),
        ],
      ),
    );
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => ref.refresh(informationHistoryViewModelProvider),
        edgeOffset: 112,
        child: body,
      ),
    );
  }
}

class _InformationDataView extends HookConsumerWidget {
  const _InformationDataView({required this.data});
  final List<InformationV3> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNext = !data.any((e) => e.id == 1);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: data.length + 1,
        (context, index) {
          if (index == data.length) {
            if (hasNext) {
              return const Center(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator.adaptive(),
              ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: SafeArea(
                  top: false,
                  child: Text(
                    'これ以上過去のお知らせはありません。',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
          final item = data[index];
          return ListTile(
            title: Text(item.title.toHalfWidth),
            subtitle: Text(
              '${dateFormat.format(item.createdAt.toLocal())}頃発表',
              style: const TextStyle(
                fontFamily: FontFamily.jetBrainsMono,
                fontFamilyFallback: [FontFamily.notoSansJP],
              ),
            ),
            onTap: () =>
                InformationHistoryDetailsRoute($extra: item).push<void>(
              context,
            ),
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'お知らせを取得中です。',
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }
}
