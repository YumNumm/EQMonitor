import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Mounts protected content only after the backend confirms Pro access.
class const ProFeatureGate({
  required final String title,
  required final Widget child,
  final VoidCallback? onClose,
  final bool isPage = false,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isProProvider)) return child;

    final prompt = Card.outlined(
      child: LockedSettingTile(
        title: title,
        subtitle: 'EQMonitor Pro にアップグレードして利用できます',
        locked: true,
        onTap: () => const ProUpgradeDialogAction().show(context),
      ),
    );
    if (!isPage) return prompt;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: onClose == null ? null : BackButton(onPressed: onClose),
      ),
      body: SafeArea(child: ListView(children: [prompt])),
    );
  }
}
