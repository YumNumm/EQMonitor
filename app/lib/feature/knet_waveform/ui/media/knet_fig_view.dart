import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// K-NET all/fig PNG 図を表示するビュー
class const KnetFigView({required final DateTime eventTime, super.key})
    extends HookConsumerWidget {
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
        return _FigContent(eventTime: eventTime, client: client);
      },
    );
  }
}

class const _FigContent({
  required final DateTime eventTime,
  required final KnetDownloadClient client,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectedType = useState(KnetFigType.values.first);
    final imageBytes = useState<Uint8List?>(null);
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);

    Future<void> loadImage() async {
      isLoading.value = true;
      errorMessage.value = null;
      imageBytes.value = null;
      try {
        final url = knetAllFigUrl(eventTime, selectedType.value);
        final bytes = await client.fetchBytes(url);
        imageBytes.value = Uint8List.fromList(bytes);
      } on Exception catch (e) {
        errorMessage.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    }

    useEffect(() {
      unawaited(loadImage());
      return null;
      // loadImage はローカル関数なので毎ビルド識別子が変わる。keysに入れると
      // 毎ビルド再取得になる。selectedType/eventTime は loadImage 内で
      // 実際に使っており（プラグインはローカル関数越しの参照を追えない）、
      // 再ロードの契機そのものなので外せない。
      // ignore_keys: loadImage, selectedType.value, eventTime
    }, [selectedType.value, eventTime]);

    return Column(
      children: [
        _FigTypeSelector(
          selected: selectedType.value,
          onChanged: (type) => selectedType.value = type,
        ),
        Expanded(
          child: _ImageArea(
            isLoading: isLoading.value,
            errorMessage: errorMessage.value,
            imageBytes: imageBytes.value,
            onRetry: loadImage,
          ),
        ),
      ],
    );
  }
}

class const _FigTypeSelector({
  required final KnetFigType selected,
  required final ValueChanged<KnetFigType> onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: 180,
        child: ControlledDropdown<KnetFigType>(
          singleSelect: true,
          items:
              (KnetFigType.values
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

class const _ImageArea({
  required final bool isLoading,
  required final VoidCallback onRetry,
  final String? errorMessage,
  final Uint8List? imageBytes,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: AccessibleCircularProgressIndicator());
    }

    if (errorMessage case final errorMessage?) {
      return _ErrorView(message: errorMessage, onRetry: onRetry);
    }

    final imageBytes = this.imageBytes;
    if (imageBytes == null) {
      return const Center(child: AccessibleCircularProgressIndicator());
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 5,
      child: Center(
        child: Image.memory(
          imageBytes,
          fit: .contain,
          errorBuilder: (context, error, _) =>
              _ErrorView(message: error.toString(), onRetry: onRetry),
        ),
      ),
    );
  }
}

class const _ErrorView({
  required final String message,
  required final VoidCallback onRetry,
}) extends StatelessWidget {
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
