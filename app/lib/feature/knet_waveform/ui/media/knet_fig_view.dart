import 'dart:async';
import 'dart:typed_data';

import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_api_client/knet_api_client.dart';

/// K-NET all/fig PNG 図を表示するビュー
class KnetFigView extends HookConsumerWidget {
  const KnetFigView({required this.eventTime, super.key});

  final DateTime eventTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(knetDownloadClientProvider);

    return clientAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
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

class _FigContent extends HookWidget {
  const _FigContent({required this.eventTime, required this.client});

  final DateTime eventTime;
  final KnetDownloadClient client;

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

class _FigTypeSelector extends StatelessWidget {
  const _FigTypeSelector({required this.selected, required this.onChanged});

  final KnetFigType selected;
  final ValueChanged<KnetFigType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownMenu<KnetFigType>(
        initialSelection: selected,
        onSelected: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        dropdownMenuEntries: KnetFigType.values
            .map((t) => DropdownMenuEntry(value: t, label: t.label))
            .toList(),
      ),
    );
  }
}

class _ImageArea extends StatelessWidget {
  const _ImageArea({
    required this.isLoading,
    required this.onRetry,
    this.errorMessage,
    this.imageBytes,
  });

  final bool isLoading;
  final String? errorMessage;
  final Uint8List? imageBytes;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage case final errorMessage?) {
      return _ErrorView(message: errorMessage, onRetry: onRetry);
    }

    final imageBytes = this.imageBytes;
    if (imageBytes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 5,
      child: Center(
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
          errorBuilder: (context, error, _) =>
              _ErrorView(message: error.toString(), onRetry: onRetry),
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
