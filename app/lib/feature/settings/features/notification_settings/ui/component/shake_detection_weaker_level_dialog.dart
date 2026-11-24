import 'package:eqmonitor/core/util/haptic.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// 非推奨の「微弱な揺れ」を通知の最小レベルに選んだときの確認を担う。
class const ShakeDetectionWeakerLevelDialogAction() {
  Future<bool> confirm(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const _ShakeDetectionWeakerLevelDialog(),
    );
    return confirmed ?? false;
  }
}

class const _ShakeDetectionWeakerLevelDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('微弱な揺れは非推奨です'),
    content: const Text(
      '微弱な揺れは、地震以外の振動を誤って検知する可能性が高く、'
      '通知の回数も多くなります。\n\n'
      'このレベルで通知しますか?',
    ),
    actions: [
      M3ETextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('キャンセル'),
      ),
      M3EFilledButton(
        onPressed: () =>
            HapticUtil.light(() => Navigator.of(context).pop(true)),
        child: const Text('設定する'),
      ),
    ],
  );
}
