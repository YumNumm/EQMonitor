import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:material_ui/material_ui.dart';

class NotificationRegionMapSelectionCard extends StatelessWidget {
  const NotificationRegionMapSelectionCard({
    required this.selection,
    required this.isResolving,
    required this.onDecideRegion,
    required this.onDecideCity,
    required this.onBackToRegion,
    super.key,
  });

  final NotificationRegionMapSelection selection;
  final bool isResolving;
  final VoidCallback onDecideRegion;
  final VoidCallback onDecideCity;
  final VoidCallback onBackToRegion;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: switch (selection) {
        NotificationRegionMapNationwide() => Row(
          children: [
            if (isResolving)
              const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            else
              const Icon(Icons.touch_app_outlined),
            const SizedBox(width: 12),
            const Expanded(child: Text('地図をタップして地域を選択')),
          ],
        ),
        NotificationRegionMapFocused(:final region) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(region.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            const Text('市区町村を選ぶ場合は地図をタップしてください'),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: isResolving ? null : onDecideRegion,
              child: const Text('この地域全域を選択'),
            ),
          ],
        ),
        NotificationRegionMapCitySelected(:final region, :final city) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(region.name, style: Theme.of(context).textTheme.bodySmall),
            Text(city.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: isResolving ? null : onDecideCity,
              child: const Text('この市区町村を選択'),
            ),
            TextButton(
              onPressed: isResolving ? null : onBackToRegion,
              child: const Text('地域全域の選択に戻る'),
            ),
          ],
        ),
      },
    ),
  );
}
