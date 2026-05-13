import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_waveform_download_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// K-NET 観測点ヘッダ情報編集画面
///
/// 観測点の基本情報を編集・確認できる。
/// 変更内容はセッション内メモリに保持する（今後永続化対応予定）。
class KnetHeaderEditPage extends HookConsumerWidget {
  const KnetHeaderEditPage({
    required this.eventTimeMs,
    required this.stationCode,
    super.key,
  });

  final int eventTimeMs;
  final String stationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(knetWaveformDownloadProvider(eventTimeMs));

    return Scaffold(
      appBar: AppBar(
        title: Text('ヘッダ編集: $stationCode'),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (stationMap) {
          final records = stationMap[stationCode];
          if (records == null) {
            return const Center(child: Text('観測点データが見つかりません'));
          }

          final representative =
              records[KnetChannelDirection.ns] ?? records.values.first;
          return _EditForm(record: representative);
        },
      ),
    );
  }
}

class _EditForm extends HookWidget {
  const _EditForm({required this.record});

  final KnetRecord record;

  @override
  Widget build(BuildContext context) {
    final info = record.stationInfo;
    final stationCodeCtrl = useTextEditingController(text: info.stationCode);
    final latCtrl = useTextEditingController(
      text: info.latitude.toStringAsFixed(4),
    );
    final lonCtrl = useTextEditingController(
      text: info.longitude.toStringAsFixed(4),
    );
    final heightCtrl = useTextEditingController(
      text: info.heightM.toStringAsFixed(1),
    );
    final memoCtrl = useTextEditingController(text: record.memo);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final isSaved = useState(false);

    void onSave() {
      if (formKey.currentState?.validate() ?? false) {
        // 現時点ではメモリ内保持のみ。
        // 将来的に SharedPreferences や Hive への永続化を実装する想定。
        isSaved.value = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存しました（セッション内一時保存）')),
        );
      }
    }

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (isSaved.value)
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'セッション内一時保存済み。アプリ再起動時はリセットされます。',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          _buildField(
            controller: stationCodeCtrl,
            label: '観測点コード',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          _buildField(
            controller: latCtrl,
            label: '緯度 (度)',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: _validateDouble,
          ),
          const SizedBox(height: 12),
          _buildField(
            controller: lonCtrl,
            label: '経度 (度)',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: _validateDouble,
          ),
          const SizedBox(height: 12),
          _buildField(
            controller: heightCtrl,
            label: '標高 (m)',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: _validateDouble,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: memoCtrl,
            decoration: const InputDecoration(
              labelText: 'メモ',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  String? _validateDouble(String? value) {
    if (value == null || value.isEmpty) {
      return '値を入力してください';
    }
    if (double.tryParse(value) == null) {
      return '数値を入力してください';
    }
    return null;
  }
}
