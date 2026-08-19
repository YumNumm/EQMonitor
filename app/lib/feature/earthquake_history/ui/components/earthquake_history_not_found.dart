import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeHistoryNotFound extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(designSystem.spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
            SizedBox(height: designSystem.spacing.sm),
            Text(
              '条件を満たす地震情報は見つかりませんでした',
              style: designSystem.typography.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EarthquakeHistoryAllFetched extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(designSystem.spacing.lg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_rounded,
                size: 48,
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
              SizedBox(height: designSystem.spacing.sm),
              Text(
                '全件取得済みです',
                style: designSystem.typography.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
