import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';

import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/media/knet_movie_seekbar.dart';
import 'package:video_player/video_player.dart';

/// K-NET all/movie MP4 をストリーミング再生するビュー
class KnetMovieView extends HookConsumerWidget {
  const new({required this.eventTime, super.key});

  final DateTime eventTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(knetDownloadClientProvider);

    return clientAsync.when(
      loading: () => const Center(child: AccessibleCircularProgressIndicator()),
      error: (e, _) => _ErrorView(
        message: 'クライアント初期化エラー: $e',
        onRetry: () =>
            ref.invalidate(knetDownloadClientProvider, asReload: true),
      ),
      data: (client) {
        if (client == null) {
          return const Center(child: Text('認証情報が設定されていません'));
        }
        return _MovieContent(eventTime: eventTime, client: client);
      },
    );
  }
}

class _MovieContent extends HookWidget {
  const new({required this.eventTime, required this.client});

  final DateTime eventTime;
  final KnetDownloadClient client;

  @override
  Widget build(BuildContext context) {
    final selectedType = useState(KnetMovieType.values.first);
    final controller = useState<VideoPlayerController?>(null);
    final isInitialized = useState(false);
    final errorMessage = useState<String?>(null);

    Future<void> loadVideo(KnetMovieType type) async {
      // dispose old controller
      final oldCtrl = controller.value;
      controller.value = null;
      isInitialized.value = false;
      errorMessage.value = null;
      await oldCtrl?.dispose();

      try {
        final url = knetAllMovieUrl(eventTime, type);
        final ctrl = VideoPlayerController.networkUrl(
          url,
          httpHeaders: {
            HttpHeaders.authorizationHeader: client.authorizationHeader,
          },
        );
        controller.value = ctrl;
        await ctrl.initialize();
        isInitialized.value = true;
      } on Exception catch (e) {
        errorMessage.value = e.toString();
      }
    }

    // 動画タイプが変わったら再ロード
    useEffect(() {
      unawaited(loadVideo(selectedType.value));
      return null;
      // ローカル関数のため毎ビルド識別子が変わる。keysに入れると毎ビルド
      // 動画を読み直してしまう。
      // ignore_keys: loadVideo
    }, [selectedType.value]);

    // ページ離脱時にコントローラーを解放
    useEffect(
      () => () {
        unawaited(controller.value?.dispose());
      },
      // アンマウント時に「その時点の」controller を解放するための const []。
      // keysに入れると差し替えのたびにcleanupが走り、loadVideo側の
      // dispose と二重解放になる。
      // ignore_keys: controller.value
      const [],
    );

    return Column(
      children: [
        _MovieTypeSelector(
          selected: selectedType.value,
          onChanged: (type) => selectedType.value = type,
        ),
        Expanded(
          child: _VideoArea(
            controller: controller.value,
            isInitialized: isInitialized.value,
            errorMessage: errorMessage.value,
            onRetry: () => loadVideo(selectedType.value),
          ),
        ),
      ],
    );
  }
}

class _MovieTypeSelector extends StatelessWidget {
  const new({required this.selected, required this.onChanged});

  final KnetMovieType selected;
  final ValueChanged<KnetMovieType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: 180,
        child: ControlledDropdown<KnetMovieType>(
          singleSelect: true,
          items:
              (KnetMovieType.values
                      .map((t) => M3EDropdownItem(value: t, label: t.label))
                      .toList())
                  .map(
                    (item) => item.copyWith(selected: item.value == selected),
                  )
                  .toList(),
          onSelectionChanged: (selection) {
            if (selection.isEmpty) return;
            final value = selection.first.value;

            onChanged(value);
          },
        ),
      ),
    );
  }
}

class _VideoArea extends HookWidget {
  const new({
    required this.controller,
    required this.isInitialized,
    required this.onRetry,
    this.errorMessage,
  });

  final VideoPlayerController? controller;
  final bool isInitialized;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (errorMessage case final errorMessage?) {
      return _ErrorView(message: errorMessage, onRetry: onRetry);
    }

    final ctrl = controller;
    if (ctrl == null || !isInitialized) {
      return const Center(child: AccessibleCircularProgressIndicator());
    }

    useListenable(ctrl);

    if (ctrl.value.hasError) {
      return _ErrorView(
        message: ctrl.value.errorDescription ?? '再生エラー',
        onRetry: onRetry,
      );
    }

    final isPlaying = ctrl.value.isPlaying;
    final duration = ctrl.value.duration;
    final position = ctrl.value.position;

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
          onRetry: onRetry,
        ),
      ],
    );
  }
}

class _VideoControls extends StatelessWidget {
  const new({
    required this.controller,
    required this.isPlaying,
    required this.duration,
    required this.position,
    required this.onRetry,
  });

  final VideoPlayerController controller;
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final VoidCallback onRetry;

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Text(_fmt(position)),
                Expanded(
                  child: KnetMovieSeekbar(
                    position: position,
                    duration: duration,
                    onChanged: (seekTo) async {
                      await controller.seekTo(seekTo);
                    },
                  ),
                ),
                Text(_fmt(duration)),
              ],
            ),
            Row(
              mainAxisAlignment: .center,
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
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  tooltip: '再読み込み',
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
  const new({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: .min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: .center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            M3EFilledButton.icon(
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
