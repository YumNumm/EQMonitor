import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/start/data/model/required_version_model.dart';
import 'package:eqmonitor/feature/start/data/model/store_url_model.dart';
import 'package:eqmonitor/feature/start/data/logic/forced_update_requirement_matcher.dart';
import 'package:eqmonitor/feature/start/data/provider/forced_update_info_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'forced_update_dialog_presenter.g.dart';

@riverpod
ForcedUpdateDialogPresenter forcedUpdateDialogPresenter(Ref ref) =>
    ForcedUpdateDialogPresenter();

/// 強制アップデートが必要か判定し、必要なら非解除可能ダイアログを表示するユースケース。
class ForcedUpdateDialogPresenter {
  /// [dialogShown] がすでに `true` の場合、または [context] が unmount 済みの場合は
  /// 何もしない。アップデートが必要な場合、ダイアログ表示を開始する直前に
  /// [markDialogShown] を呼び出してから表示する。
  Future<void> checkAndShow({
    required WidgetRef ref,
    required BuildContext context,
    required bool dialogShown,
    required void Function() markDialogShown,
  }) async {
    if (dialogShown || !context.mounted) {
      return;
    }

    final forcedUpdateInfo = ref.read(forcedUpdateInfoProvider).value;
    if (forcedUpdateInfo == null) {
      return;
    }

    final requiredVersions = forcedUpdateInfo.requiredVersions;
    if (requiredVersions.isEmpty) {
      return;
    }

    final info = ref.read(packageInfoProvider);
    final matcher = ForcedUpdateRequirementMatcher(packageInfo: info);

    for (final req in requiredVersions) {
      if (matcher.isUpdateRequired(req)) {
        if (!context.mounted) {
          return;
        }
        markDialogShown();
        await showForcedUpdateDialog(
          context,
          req: req,
          storeUrl: forcedUpdateInfo.storeUrl,
        );
        return;
      }
    }
  }

  Future<void> showForcedUpdateDialog(
    BuildContext context, {
    required RequiredVersionModel req,
    required StoreUrlModel storeUrl,
  }) {
    final url = resolveStoreUrl(storeUrl);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('アップデートが必要です'),
          content: Text(
            req.message ?? '最新バージョンへのアップデートが必要です。ストアよりアップデートを行ってください。',
          ),
          actions: [
            FilledButton(
              onPressed: url != null
                  ? () {
                      unawaited(
                        launchUrlString(
                          url,
                          mode: LaunchMode.externalApplication,
                        ),
                      );
                    }
                  : null,
              child: const Text('アップデートする'),
            ),
          ],
        ),
      ),
    );
  }

  String? resolveStoreUrl(StoreUrlModel storeUrl) {
    if (kIsWeb) {
      return null;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return storeUrl.ios;
    }
    if (Platform.isAndroid) {
      return storeUrl.android;
    }
    return null;
  }
}
