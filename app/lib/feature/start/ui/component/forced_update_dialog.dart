import 'dart:async';

import 'package:eqmonitor/feature/start/data/flow/forced_update_dialog_presenter.dart';
import 'package:eqmonitor/feature/start/data/provider/forced_update_info_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 強制アップデートが必要かどうかを監視し、必要なら非解除可能ダイアログを表示するWrapper。
class ForcedUpdateWrapper extends HookConsumerWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogShown = useRef(false);
    final presenter = ref.watch(forcedUpdateDialogPresenterProvider);

    void scheduleCheck() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(
          presenter.checkAndShow(
            ref: ref,
            context: context,
            dialogShown: dialogShown.value,
            markDialogShown: () => dialogShown.value = true,
          ),
        );
      });
    }

    useEffect(() {
      scheduleCheck();
      return null;
      // 初回のみ実行する意図の const []（更新時の再チェックは下の
      // ref.listen が担当）。ローカル関数を keys に入れると毎ビルド走る。
      // ignore_keys: scheduleCheck
    }, const []);

    // Start APIが更新されたときにも再チェックする
    ref.listen(forcedUpdateInfoProvider, (_, next) {
      if (next.value != null && !dialogShown.value) {
        scheduleCheck();
      }
    });

    return child;
  }
}
