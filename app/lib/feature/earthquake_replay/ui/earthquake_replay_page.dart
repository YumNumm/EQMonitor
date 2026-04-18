import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_controls.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_data_overlay.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_map_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeReplayPage extends HookConsumerWidget {
  const EarthquakeReplayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replayState = ref.watch(replayProvider);
    final isLoading = useState(false);

    final fileName = replayState?.fileName;
    final showOverlay = replayState?.showDataOverlay ?? false;

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('リプレイ再生'),
          subtitle: fileName != null ? Text(fileName) : null,
        ),
        actions: [
          if (replayState != null)
            IconButton(
              icon: Icon(
                showOverlay ? Icons.list_alt : Icons.list_alt_outlined,
              ),
              onPressed: () =>
                  ref.read(replayProvider.notifier).toggleDataOverlay(),
              tooltip: showOverlay ? 'イベントログを非表示' : 'イベントログを表示',
            ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: isLoading.value
                ? null
                : () => _pickAndLoadFile(context, ref, isLoading),
            tooltip: 'ファイルを選択',
          ),
        ],
      ),
      body: replayState == null
          ? _FileSelectionView(
              isLoading: isLoading.value,
              onPickFile: () => _pickAndLoadFile(context, ref, isLoading),
            )
          : const _ReplayView(),
    );
  }

  Future<void> _pickAndLoadFile(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<bool> isLoading,
  ) async {
    isLoading.value = true;

    try {
      final result = await FilePicker.pickFiles(withData: true);

      if (result == null || result.files.isEmpty) {
        isLoading.value = false;
        return;
      }

      final file = result.files.first;
      if (file.bytes == null) {
        isLoading.value = false;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ファイルの読み込みに失敗しました'),
            ),
          );
        }
        return;
      }

      await ref
          .read(replayProvider.notifier)
          .loadFile(
            bytes: file.bytes!,
            fileName: file.name,
          );
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}

class _FileSelectionView extends StatelessWidget {
  const _FileSelectionView({
    required this.isLoading,
    required this.onPickFile,
  });

  final bool isLoading;
  final VoidCallback onPickFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_file_outlined,
              size: 80,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'リプレイファイルを選択',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'KyoshinEewViewerIngen形式のリプレイファイル(.eqrp)を\n読み込んで再生できます',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            if (isLoading)
              const CircularProgressIndicator.adaptive()
            else
              FilledButton.icon(
                onPressed: onPickFile,
                icon: const Icon(Icons.folder_open),
                label: const Text('ファイルを選択'),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReplayView extends HookConsumerWidget {
  const _ReplayView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return Column(
      children: [
        Expanded(
          child: switch (mapConfiguration) {
            AsyncData(:final value) when value.styleString != null =>
              _MapContent(styleString: value.styleString!),
            AsyncError(:final error) => Center(child: ErrorCard(error: error)),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
        ),
        const ReplayControls(),
      ],
    );
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({required this.styleString});

  final String styleString;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replayState = ref.watch(replayProvider);
    final showOverlay = replayState?.showDataOverlay ?? false;
    final recentEvents = replayState?.recentEvents ?? [];

    final mapOptions = MapOptions(
      initCenter: const Geographic(lon: 138, lat: 36.5),
      initZoom: 4.5,
      initStyle: styleString,
    );

    return Stack(
      children: [
        MapLibreMap(
          options: mapOptions,
          children: const [
            ReplayMapLayer(),
          ],
        ),
        if (replayState != null)
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: _InfoCard(
                softwareName: replayState.file.header.softwareName,
              ),
            ),
          ),
        if (showOverlay)
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: ReplayDataOverlay(events: recentEvents),
            ),
          ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.softwareName});

  final String softwareName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            softwareName,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
