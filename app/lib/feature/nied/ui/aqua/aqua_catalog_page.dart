import 'dart:developer';
import 'dart:typed_data';

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/nied/data/provider/nied_api_client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nied_api_client/nied_api_client.dart';

class AquaCatalogPage extends HookConsumerWidget {
  const AquaCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState<DateTime?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AQUAシステム メカニズム解カタログ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate.value ?? now,
                firstDate: DateTime(2004, 8),
                lastDate: now,
              );
              if (picked != null) {
                selectedDate.value = picked;
              }
            },
          ),
          if (selectedDate.value != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                selectedDate.value = null;
              },
            ),
        ],
      ),
      body: _AquaCatalogList(selectedDate: selectedDate.value),
    );
  }
}

class _AquaCatalogList extends HookConsumerWidget {
  const _AquaCatalogList({required this.selectedDate});

  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final niedApiClient = ref.watch(niedApiClientProvider);

    final future = useMemoized(
      () async {
        final response = await niedApiClient.hinet.aqua.catalog.getCatalogHtml(
          year: selectedDate?.year,
          month: selectedDate?.month,
          onReceiveProgress: (received, total) {
            log(
              'received: $received, total: $total',
              name: 'onReceiveProgress',
            );
          },
        );
        final parser = AquaHtmlParser();
        return parser.parseCatalog(
          bytes: Uint8List.fromList(response.data),
        );
      },
      [selectedDate],
    );

    final snapshot = useFuture(future);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('エラーが発生しました\n${snapshot.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                (context as Element).markNeedsBuild();
              },
              child: const Text('再試行'),
            ),
          ],
        ),
      );
    }

    final events = snapshot.data ?? [];

    if (events.isEmpty) {
      return const Center(
        child: Text('データがありません'),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final event = events[index];
        return _EventCard(event: event);
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final AquaEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return ListTile(
      titleTextStyle: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      title: Text(event.region),
      subtitle: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(
          fontFamily: FontFamily.jetBrainsMono,
          fontFamilyFallback: [FontFamily.notoSansJP],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('発生日時: ${dateFormat.format(event.originTime.toLocal())}'),
            Text(
              'M${event.magnitude.toStringAsFixed(1)} / 深さ ${event.depth.toStringAsFixed(1)}km',
            ),
            Text(
              '緯度 ${event.latitude.toStringAsFixed(2)}° / 経度 ${event.longitude.toStringAsFixed(2)}°',
            ),
            Text(
              '${event.type.fullName} / 観測点数: ${event.stationCount}',
            ),
            if (event.varianceReduction != null)
              Text(
                '品質: ${event.varianceReduction!.toStringAsFixed(1)}%',
              ),
          ],
        ),
      ),
    );
  }
}
