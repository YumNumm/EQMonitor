import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef NotificationRegionPickerResult = ({
  int regionId,
  String regionName,
  JmaIntensity minIntensity,
});

Future<NotificationRegionPickerResult?> showNotificationRegionPickerDialog(
  BuildContext context, {
  bool allRegionAlreadyAdded = false,
}) => showAdaptiveDialog<NotificationRegionPickerResult>(
      context: context,
      builder: (_) => _RegionPickerDialog(
        allRegionAlreadyAdded: allRegionAlreadyAdded,
      ),
    );

enum _RegionMode { all, prefecture }

const List<JmaIntensity> _kIntensities = [
  JmaIntensity.one,
  JmaIntensity.two,
  JmaIntensity.three,
  JmaIntensity.four,
  JmaIntensity.fiveLower,
  JmaIntensity.fiveUpper,
  JmaIntensity.sixLower,
  JmaIntensity.sixUpper,
  JmaIntensity.seven,
];

class _RegionPickerDialog extends HookConsumerWidget {
  const _RegionPickerDialog({this.allRegionAlreadyAdded = false});

  final bool allRegionAlreadyAdded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = useState(
      allRegionAlreadyAdded ? _RegionMode.prefecture : _RegionMode.all,
    );
    final selectedCode = useState<String?>(null);
    final selectedName = useState<String?>(null);
    final intensity = useState(JmaIntensity.four);

    final isAllMode = mode.value == _RegionMode.all;
    final canSubmit = isAllMode || selectedCode.value != null;

    return AlertDialog.adaptive(
      title: const Text('地域を追加'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<_RegionMode>(
            segments: [
              ButtonSegment(
                value: _RegionMode.all,
                label: const Text('全国'),
                icon: const Icon(Icons.public_outlined),
                enabled: !allRegionAlreadyAdded,
              ),
              const ButtonSegment(
                value: _RegionMode.prefecture,
                label: Text('都道府県'),
                icon: Icon(Icons.map_outlined),
              ),
            ],
            selected: {mode.value},
            onSelectionChanged: (s) {
              mode.value = s.first;
              selectedCode.value = null;
              selectedName.value = null;
            },
          ),
          const SizedBox(height: 16),
          if (!isAllMode) ...[
            PrefectureSelector(
              selectedCode: selectedCode.value,
              onChanged: (sel) {
                selectedCode.value = sel?.code;
                selectedName.value = sel?.name;
              },
            ),
            const SizedBox(height: 16),
          ],
          DropdownMenu<JmaIntensity>(
            expandedInsets: EdgeInsets.zero,
            initialSelection: intensity.value,
            label: const Text('最小震度'),
            onSelected: (v) {
              if (v != null) {
                intensity.value = v;
              }
            },
            dropdownMenuEntries: _kIntensities
                .map(
                  (i) => DropdownMenuEntry(
                    value: i,
                    label: '震度${i.mainText}${i.suffix}以上',
                  ),
                )
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: canSubmit
              ? () {
                  final code = selectedCode.value;
                  final name = selectedName.value;
                  if (!isAllMode && code == null) {
                    return;
                  }
                  Navigator.of(context).pop(
                    (
                      regionId: isAllMode ? 0 : int.parse(code!),
                      regionName: isAllMode ? '全国' : (name ?? ''),
                      minIntensity: intensity.value,
                    ),
                  );
                }
              : null,
          child: const Text('追加'),
        ),
      ],
    );
  }
}

class NotificationRegionListTile extends StatelessWidget {
  const NotificationRegionListTile({
    required this.region,
    required this.isBusy,
    required this.onDelete,
    super.key,
  });

  final NotificationRegion region;
  final bool isBusy;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final String name;
    final String? subtitleSuffix;
    if (region.isCurrentLocation) {
      name = '現在地';
      subtitleSuffix = region.regionName;
    } else if (region.regionId == 0) {
      name = '全国';
      subtitleSuffix = null;
    } else {
      name = region.regionName ?? '地域ID: ${region.regionId}';
      subtitleSuffix = null;
    }

    final threshold = region.minJmaIntensity;
    final subtitle = subtitleSuffix != null
        ? '$subtitleSuffix・震度${threshold.mainText}${threshold.suffix}以上で通知'
        : '震度${threshold.mainText}${threshold.suffix}以上で通知';

    return ListTile(
      leading: Icon(
        region.isCurrentLocation
            ? Icons.my_location_outlined
            : region.regionId == 0
            ? Icons.public_outlined
            : Icons.location_on_outlined,
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: isBusy
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : IconButton(
              tooltip: '削除',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
    );
  }
}
