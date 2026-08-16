import 'package:material_ui/material_ui.dart';

/// カスタム設定から他プリセットへ切り替える前の確認ダイアログの表示を担う。
class CustomPresetResetConfirmDialogAction {
  const CustomPresetResetConfirmDialogAction();

  /// 承諾したら true を返す。ダイアログを閉じずに離脱した場合は
  /// 変更なし（キャンセル相当）として false を返す。
  Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('カスタム設定を変更しますか？'),
        content: const Text(
          'プリセットを選ぶと、現在のカスタム設定は解除されます。'
          'もう一度カスタムを選ぶと元の設定に戻せます。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('変更する'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
