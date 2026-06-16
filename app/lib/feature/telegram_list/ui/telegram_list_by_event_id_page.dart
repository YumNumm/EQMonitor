import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_details_notifier.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/earthquake_telegram_tile.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/telegram_list_tile.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ---------------------------------------------------------------------------
// Section type constants
// ---------------------------------------------------------------------------

const Set<TelegramType> _eewTypes = {
  TelegramType.vxse43,
  TelegramType.vxse44,
  TelegramType.vxse45,
};

const Set<TelegramType> _earthquakeTypes = {
  TelegramType.vxse51,
  TelegramType.vxse52,
  TelegramType.vxse53,
  TelegramType.vxse61,
  TelegramType.vxse62,
};

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class TelegramListByEventIdPage extends HookConsumerWidget {
  const TelegramListByEventIdPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(telegramListByEventIdProvider(eventId));
    final asyncDetails = ref.watch(telegramDetailsProvider(eventId));
    final scrollController = useScrollController();

    // Pagination: fetch next page when near bottom.
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
        onRefresh: () async {
          ref.invalidate(telegramListByEventIdProvider(eventId), asReload: true);
          ref.invalidate(telegramDetailsProvider(eventId), asReload: true);
        },
        child: switch (asyncState) {
          AsyncData(:final value) => _SectionedList(
              items: value.items,
              hasNext: value.hasNext,
              isLoading: asyncState.isLoading,
              scrollController: scrollController,
              details: asyncDetails.value ?? const {},
            ),
          AsyncError(:final error, :final value?) => _SectionedList(
              items: value.items,
              hasNext: value.hasNext,
              isLoading: false,
              scrollController: scrollController,
              details: asyncDetails.value ?? const {},
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

// ---------------------------------------------------------------------------
// Sectioned list
// ---------------------------------------------------------------------------

/// A flat widget list rendered inside a single [ListView] so that the
/// scroll-based pagination still fires from [scrollController].
class _SectionedList extends StatelessWidget {
  const _SectionedList({
    required this.items,
    required this.hasNext,
    required this.isLoading,
    required this.scrollController,
    required this.details,
    this.error,
    this.onReload,
  });

  final List<TelegramItem> items;
  final bool hasNext;
  final bool isLoading;
  final ScrollController scrollController;
  final Map<String, api.TelegramDetailResponse> details;
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

    // Split items into sections (preserve original sort order within each).
    final eewItems = items.where((t) => _eewTypes.contains(t.type)).toList();
    final earthquakeItems =
        items.where((t) => _earthquakeTypes.contains(t.type)).toList();
    final otherItems = items
        .where(
          (t) => !_eewTypes.contains(t.type) && !_earthquakeTypes.contains(t.type),
        )
        .toList();

    // Pre-compute sequence numbers & previous body for earthquake items.
    final seqInfo = _computeSequenceInfo(earthquakeItems);

    // Build a flat list of widgets.
    final widgets = <Widget>[];

    if (eewItems.isNotEmpty) {
      widgets.add(const _SectionHeader(title: '緊急地震速報'));
      widgets.add(
        _EewNavigationCard(
          count: eewItems.length,
          onTap: () => EewDetailsByEventIdRoute(
            eventId: eewItems.first.eventId,
          ).push<void>(context),
        ),
      );
    }

    if (earthquakeItems.isNotEmpty) {
      widgets.add(const _SectionHeader(title: '地震情報'));
      for (final telegram in earthquakeItems) {
        final info = seqInfo[telegram.id];
        final detail = details[telegram.id];
        final body = detail?.telegram.body;

        if (body is api.TelegramBodyUnionEarthquakeTelegramBody) {
          // Look up previous body.
          api.TelegramBodyUnionEarthquakeTelegramBody? previousBody;
          if (info != null && info.previousId != null) {
            final prevDetail = details[info.previousId];
            final prevBody = prevDetail?.telegram.body;
            if (prevBody is api.TelegramBodyUnionEarthquakeTelegramBody) {
              previousBody = prevBody;
            }
          }

          widgets.add(
            EarthquakeTelegramTile(
              telegram: telegram,
              comments: detail?.comments,
              body: body,
              sequenceNumber: info?.sequenceNumber ?? 1,
              previousBody: previousBody,
            ),
          );
        } else {
          // Fallback when body is not yet loaded or type doesn't match.
          widgets.add(TelegramListTile(telegram: telegram));
        }
      }
    }

    if (otherItems.isNotEmpty) {
      widgets.add(const _SectionHeader(title: 'その他'));
      for (final telegram in otherItems) {
        widgets.add(TelegramListTile(telegram: telegram));
      }
    }

    // Error banner (when we have cached data but a refresh failed).
    if (error != null) {
      widgets.insert(
        0,
        MaterialBanner(
          content: Text('読み込みに失敗しました: $error'),
          actions: [
            if (onReload != null)
              TextButton(
                onPressed: onReload,
                child: const Text('再読み込み'),
              ),
          ],
        ),
      );
    }

    // Bottom loading indicator for pagination.
    if (hasNext || isLoading) {
      widgets.add(
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }

  /// Group earthquake items by type, sort each group by pressAt ascending,
  /// and assign 1-based sequence numbers. Returns a map from telegram id
  /// to its sequence number and the id of the previous telegram of the same
  /// type (null for the first in each group).
  Map<String, _SequenceInfo> _computeSequenceInfo(
    List<TelegramItem> earthquakeItems,
  ) {
    final result = <String, _SequenceInfo>{};
    final byType = <TelegramType, List<TelegramItem>>{};

    for (final item in earthquakeItems) {
      (byType[item.type] ??= []).add(item);
    }

    for (final group in byType.values) {
      // Sort ascending by pressAt for sequence numbering.
      group.sort((a, b) => a.pressAt.compareTo(b.pressAt));
      for (var i = 0; i < group.length; i++) {
        result[group[i].id] = _SequenceInfo(
          sequenceNumber: i + 1,
          previousId: i > 0 ? group[i - 1].id : null,
        );
      }
    }

    return result;
  }
}

class _SequenceInfo {
  const _SequenceInfo({required this.sequenceNumber, this.previousId});
  final int sequenceNumber;
  final String? previousId;
}

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// EEW navigation card
// ---------------------------------------------------------------------------

class _EewNavigationCard extends StatelessWidget {
  const _EewNavigationCard({
    required this.count,
    required this.onTap,
  });

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(Icons.warning_amber_rounded, color: colorScheme.error),
        title: Text(
          '緊急地震速報（$count報）',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skeleton
// ---------------------------------------------------------------------------

class _TelegramListSkeleton extends StatelessWidget {
  const _TelegramListSkeleton();

  @override
  Widget build(BuildContext context) {
    const itemCount = 6;
    return Skeletonizer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var i = 0; i < itemCount; i++)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 180,
                      height: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
