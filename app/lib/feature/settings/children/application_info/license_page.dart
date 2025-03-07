import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart' hide LicensePage;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LicensePage extends ConsumerWidget {
  const LicensePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    return material.LicensePage(
      applicationName: 'EQMonitor',
      applicationLegalese:
          '${DateTime.now().year} © Ryotaro Onoue All Rights Reserved.',
      applicationVersion:
          'v${packageInfo.version} (${packageInfo.buildNumber})',
      applicationIcon: material.Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Assets.images.icon.image(height: 80),
            ),
          ),
          TextButton(
            child: const Text('https://github.com/YumNumm/EQMonitor'),
            onPressed:
                () async =>
                    launchUrlString('https://github.com/YumNumm/EQMonitor'),
          ),
          TextButton(
            child: const Text('https://license.eqmonitor.app'),
            onPressed:
                () async => launchUrlString('https://license.eqmonitor.app'),
          ),
        ],
      ),
    );
  }
}
