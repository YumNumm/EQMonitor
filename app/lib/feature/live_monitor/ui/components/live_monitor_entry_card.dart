import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';

class LiveMonitorEntryCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;

    return Material(
      clipBehavior: .antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),

      child: Card.outlined(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: const Icon(Icons.monitor_heart_outlined),
          title: const Text('LiveMonitor モード'),
          subtitle: const Text('地震情報を常時表示'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            await const LiveMonitorRoute().push<void>(context);
          },
        ),
      ),
    );
  }
}
