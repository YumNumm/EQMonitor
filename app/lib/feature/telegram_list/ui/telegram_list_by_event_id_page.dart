import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/telegram_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TelegramListByEventIdPage extends HookConsumerWidget {
  const TelegramListByEventIdPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(telegramListByEventIdProvider(eventId));
    final scrollController = useScrollController();

    useEffect(
      () {
        Future<void> onScroll() async {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
            await ref
                .read(telegramListByEventIdProvider(eventId).notifier)
                .fetchNextData();
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('電文一覧')),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.read(telegramListByEventIdProvider(eventId).notifier).refresh(),
        child: switch (asyncState) {
          AsyncData(:final value) => _TelegramListView(
              items: value.items,
              hasNext: value.hasNext,
              isLoading: asyncState.isLoading,
              scrollController: scrollController,
            ),
          AsyncError(:final error) when asyncState.hasValue =>
            _TelegramListView(
              items: asyncState.value!.items,
              hasNext: asyncState.value!.hasNext,
              isLoading: false,
              scrollController: scrollController,
              error: error,
              onReload: () async => ref
                  .read(telegramListByEventIdProvider(eventId).notifier)
                  .refresh(),
            ),
          AsyncError(:final error) => ErrorCard(
              error: error,
              onReload: () async => ref
                  .read(telegramListByEventIdProvider(eventId).notifier)
                  .refresh(),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _TelegramListView extends StatelessWidget {
  const _TelegramListView({
    required this.items,
    required this.hasNext,
    required this.isLoading,
    required this.scrollController,
    this.error,
    this.onReload,
  });

  final List<Telegram> items;
  final bool hasNext;
  final bool isLoading;
  final ScrollController scrollController;
  final Object? error;
  final Future<void> Function()? onReload;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('電文がありません'));
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: items.length + 1,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _buildFooter(context);
        }
        final telegram = items[index];
        return TelegramListTile(telegram: telegram);
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return ErrorCard(error: error!, onReload: onReload);
    }
    if (hasNext) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'すべての電文を取得しました',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
