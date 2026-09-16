import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_url_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contact_action.g.dart';

@Riverpod(keepAlive: true)
TargetPlatform contactTargetPlatform(Ref ref) => defaultTargetPlatform;

@Riverpod(keepAlive: true)
Future<Uri> contactUrl(Ref ref) async {
  final deviceId = await ref.read(deviceIdProvider.future);
  final packageInfo = ref.read(packageInfoProvider);
  const builder = ContactUrlBuilder();

  return switch (ref.read(contactTargetPlatformProvider)) {
    TargetPlatform.android => builder.buildForAndroid(
      deviceId: deviceId,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      deviceInfo: ref.read(androidDeviceInfoProvider),
    ),
    TargetPlatform.iOS => builder.buildForIos(
      deviceId: deviceId,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      deviceInfo: ref.read(iosDeviceInfoProvider),
    ),
    _ => throw UnsupportedError('Unsupported contact platform'),
  };
}

@Riverpod(keepAlive: true)
Future<bool> Function(Uri) contactUrlLauncher(Ref ref) =>
    (url) => launchUrl(url, mode: LaunchMode.externalApplication);

@Riverpod(keepAlive: true)
OpenContactAction openContact(Ref ref) => const OpenContactAction();

/// 問い合わせページを開く。呼び出し側は `open(ref, context)` のように
/// 関数として扱える([call]による callable object)。
class OpenContactAction {
  const new();

  Future<void> call(WidgetRef ref, BuildContext context) async {
    try {
      final url = await ref.read(contactUrlProvider.future);
      final launched = await ref.read(contactUrlLauncherProvider)(url);
      if (!context.mounted || launched) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('問い合わせページを開けませんでした')));
    } on Exception {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('問い合わせページを開けませんでした')));
    }
  }
}
