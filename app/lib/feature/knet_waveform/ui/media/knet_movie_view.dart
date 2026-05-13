import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

/// K-NET all/movie MP4 をダウンロード・再生するビュー
class KnetMovieView extends HookConsumerWidget {
  const KnetMovieView({required this.eventTime, super.key});

  final DateTime eventTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(knetDownloadClientProvider);

    return clientAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorView(
        message: 'クライアント初期化エラー: $e',
        onRetry: () => ref.invalidate(knetDownloadClientProvider),
      ),
      data: (client) {
        if (client == null) {
          return const Center(
            child: Text('認証情報が設定されていません'),
          );
        }
        return _MovieContent(eventTime: eventTime, client: client);
      },
    );
  }
}

enum _DownloadState { idle, downloading, ready, error }

class _MovieContent extends HookWidget {
  const _MovieContent({required this.eventTime, required this.client});

  final DateTime eventTime;
  final KnetDownloadClient client;

  @override
  Widget build(BuildContext context) {
    final downloadState = useState(_DownloadState.idle);
    final downloadProgress = useState<double>(0);
    final errorMessage = useState<String?>(null);
    final localFile = useState<File?>(null);
    final controller = useState<VideoPlayerController?>(null);
    final isControllerInit = useState(false);

    Future<void> download() async {
      downloadState.value = _DownloadState.downloading;
      downloadProgress.value = 0;
      errorMessage.value = null;
      localFile.value = null;

      // Dispose old controller if any
      final oldCtrl = controller.value;
      controller.value = null;
      isControllerInit.value = false;
      await oldCtrl?.dispose();

      try {
        final url = knetAllMovieUrl(eventTime);
        final bytes = await client.fetchBytes(url);
        final dir = await getTemporaryDirectory();
        final fileName = '${eventTime.millisecondsSinceEpoch}_knet.mp4';
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        localFile.value = file;
        downloadState.value = _DownloadState.ready;
      } on Exception catch (e) {
        errorMessage.value = e.toString();
        downloadState.value = _DownloadState.error;
      }
    }

    // Initialize video controller when file is ready
    useEffect(
      () {
        final file = localFile.value;
        if (file == null) {
          return null;
        }
        final ctrl = VideoPlayerController.file(file);
        controller.value = ctrl;
        isControllerInit.value = false;

        unawaited(
          ctrl.initialize().then((_) {
            isControllerInit.value = true;
          }),
        );

        return ctrl.dispose;
      },
      [localFile.value],
    );

    return switch (downloadState.value) {
      _DownloadState.idle => Center(
        child: FilledButton.icon(
          onPressed: download,
          icon: const Icon(Icons.download),
          label: const Text('MP4 をダウンロード'),
        ),
      ),
      _DownloadState.downloading => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'ダウンロード中...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (downloadProgress.value > 0) ...[
                const SizedBox(height: 8),
                LinearProgressIndicator(value: downloadProgress.value),
              ],
            ],
          ),
        ),
      ),
      _DownloadState.error => _ErrorView(
        message: errorMessage.value ?? '不明なエラー',
        onRetry: download,
      ),
      _DownloadState.ready => _VideoArea(
        controller: controller.value,
        isInitialized: isControllerInit.value,
        onRedownload: download,
      ),
    };
  }
}

class _VideoArea extends HookWidget {
  const _VideoArea({
    required this.controller,
    required this.isInitialized,
    required this.onRedownload,
  });

  final VideoPlayerController? controller;
  final bool isInitialized;
  final VoidCallback onRedownload;

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    if (ctrl == null || !isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // Rebuild when playback state changes
    useListenable(ctrl);

    final isPlaying = ctrl.value.isPlaying;
    final duration = ctrl.value.duration;
    final position = ctrl.value.position;
    final hasError = ctrl.value.hasError;

    if (hasError) {
      return _ErrorView(
        message: ctrl.value.errorDescription ?? '再生エラー',
        onRetry: onRedownload,
      );
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: ctrl.value.aspectRatio,
              child: VideoPlayer(ctrl),
            ),
          ),
        ),
        _VideoControls(
          controller: ctrl,
          isPlaying: isPlaying,
          duration: duration,
          position: position,
          onRedownload: onRedownload,
        ),
      ],
    );
  }
}

class _VideoControls extends StatelessWidget {
  const _VideoControls({
    required this.controller,
    required this.isPlaying,
    required this.duration,
    required this.position,
    required this.onRedownload,
  });

  final VideoPlayerController controller;
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final VoidCallback onRedownload;

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final total = duration.inMilliseconds;
    final current = position.inMilliseconds;
    final sliderValue = total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(_formatDuration(position)),
                Expanded(
                  child: Slider(
                    value: sliderValue,
                    onChanged: (v) {
                      final seekTo = Duration(
                        milliseconds: (total * v).toInt(),
                      );
                      unawaited(controller.seekTo(seekTo));
                    },
                  ),
                ),
                Text(_formatDuration(duration)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => unawaited(controller.seekTo(Duration.zero)),
                  icon: const Icon(Icons.skip_previous),
                  tooltip: '先頭に戻る',
                ),
                IconButton.filled(
                  onPressed: () {
                    if (isPlaying) {
                      unawaited(controller.pause());
                    } else {
                      unawaited(controller.play());
                    }
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 36,
                  tooltip: isPlaying ? '一時停止' : '再生',
                ),
                IconButton(
                  onPressed: onRedownload,
                  icon: const Icon(Icons.refresh),
                  tooltip: '再ダウンロード',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}
