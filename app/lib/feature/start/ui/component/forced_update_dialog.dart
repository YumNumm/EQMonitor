// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:version/version.dart';

/// 強制アップデートが必要かどうかを監視し、必要なら非解除可能ダイアログを表示するWrapper。
class ForcedUpdateWrapper extends ConsumerStatefulWidget {
  const ForcedUpdateWrapper({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<ForcedUpdateWrapper> createState() =>
      _ForcedUpdateWrapperState();
}

class ForcedUpdateRequirementMatcher {
  const ForcedUpdateRequirementMatcher({required this.packageInfo});

  final PackageInfo packageInfo;

  bool isUpdateRequired(api.RequiredVersion requiredVersion) {
    final versionUpdateRequired = isVersionUpdateRequired(requiredVersion);
    final buildUpdateRequired = isBuildNumberUpdateRequired(requiredVersion);
    return versionUpdateRequired || buildUpdateRequired;
  }

  bool isVersionUpdateRequired(api.RequiredVersion requiredVersion) {
    final requiredVersionString = requiredVersion.version;
    if (requiredVersionString == null) {
      return false;
    }

    Version current;
    Version required;
    try {
      current = Version.parse(packageInfo.version);
      required = Version.parse(requiredVersionString);
    } on FormatException {
      return false;
    }
    return current < required;
  }

  bool isBuildNumberUpdateRequired(api.RequiredVersion requiredVersion) {
    final requiredBuildNumber = requiredVersion.buildNumber;
    if (requiredBuildNumber == null) {
      return false;
    }

    final currentBuildNumber = int.tryParse(packageInfo.buildNumber);
    if (currentBuildNumber == null) {
      return false;
    }
    return currentBuildNumber < requiredBuildNumber;
  }
}

class _ForcedUpdateWrapperState extends ConsumerState<ForcedUpdateWrapper> {
  var _dialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_checkAndShow());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Start APIが更新されたときにも再チェックする
    ref.listen(startProvider, (_, next) {
      if (next.value != null && !_dialogShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          unawaited(_checkAndShow());
        });
      }
    });
    return widget.child;
  }

  Future<void> _checkAndShow() async {
    if (_dialogShown || !mounted) {
      return;
    }

    final startData = ref.read(startProvider).value;
    if (startData == null) {
      return;
    }

    final requiredVersions = startData.app.version.requiredVersions;
    if (requiredVersions.isEmpty) {
      return;
    }

    final info = ref.read(packageInfoProvider);
    final matcher = ForcedUpdateRequirementMatcher(packageInfo: info);

    for (final req in requiredVersions) {
      if (matcher.isUpdateRequired(req)) {
        if (!mounted) {
          return;
        }
        setState(() => _dialogShown = true);
        await _showDialog(context, req: req, storeUrl: startData.app.storeUrl);
        return;
      }
    }
  }

  Future<void> _showDialog(
    BuildContext context, {
    required api.RequiredVersion req,
    required api.StoreUrl storeUrl,
  }) {
    final url = _resolveStoreUrl(storeUrl);
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

  String? _resolveStoreUrl(api.StoreUrl storeUrl) {
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
