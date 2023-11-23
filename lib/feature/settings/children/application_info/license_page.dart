import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart' hide LicensePage;
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      applicationIcon: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Assets.images.icon.image(
            height: 80,
          ),
        ),
      ),
    );
  }
}
