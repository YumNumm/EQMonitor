import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// 通知地域の削除確認ダイアログの表示を担う。
class const RegionDeleteConfirmDialogAction() {
  /// 削除が確定された場合のみ true を返す。
  Future<bool> show(BuildContext context, {required String name}) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _RegionDeleteConfirmDialog(name: name),
    );
    return confirmed ?? false;
  }
}

class _RegionDeleteConfirmDialog extends StatelessWidget {
  const new({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return AlertDialog(
      title: Text('$nameを削除しますか？'),
      content: const Text('この地域の通知条件と震度別設定も削除されます。'),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('削除', style: TextStyle(color: colorTheme.error)),
        ),
      ],
    );
  }
}
