import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/telegram_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            ref.refresh(telegramListByEventIdProvider(eventId).notifier),
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
              onReload: () async =>
                  ref.refresh(telegramListByEventIdProvider(eventId)),
            ),
          AsyncError(:final error) => ErrorCard(
            error: error,
            onReload: () async =>
                ref.refresh(telegramListByEventIdProvider(eventId)),
          ),
          _ => const _TelegramListSkeleton(),
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

  final List<TelegramItem> items;
  final bool hasNext;
  final bool isLoading;
  final ScrollController scrollController;
  final Object? error;
  final Future<void> Function()? onReload;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const AppEmptyState(
        message: '電文はありません',
        icon: Icons.description_outlined,
      );
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: items.length + 1,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final telegram = items[index];
        return TelegramListTile(
          telegram: telegram,
          onTap: _getOnTapCallback(context, telegram),
        );
      },
    );
  }

  VoidCallback? _getOnTapCallback(BuildContext context, TelegramItem telegram) {
    return switch (telegram.type) {
      TelegramType.vxse43 ||
      TelegramType.vxse44 ||
      TelegramType.vxse45 => () => EewDetailsByEventIdRoute(
        eventId: telegram.eventId,
      ).push<void>(context),
      _ => null,
    };
  }

  Widget _buildFooter(BuildContext context) {
    if (isLoading) {
      return const _TelegramListSkeleton();
    }
    if (error != null) {
      return ErrorCard(error: error!, onReload: onReload);
    }
    if (hasNext) {
      return const _TelegramListSkeleton();
    }
    return const SizedBox.shrink();
  }
}

class _TelegramListSkeleton extends StatelessWidget {
  const _TelegramListSkeleton();

  @override
  Widget build(BuildContext context) {
    const itemCount = 10;
    return Skeletonizer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final i in List.generate(itemCount, (i) => i)) ...[
            ListTile(
              leading: const CircleAvatar(radius: 16),
              title: Text('VXSE4${i + 3} 2026/04/21 12:34:56'),
              subtitle: const Text('eventId: 20260421123456'),
            ),
            if (i < itemCount - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}
